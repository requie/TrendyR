Chewy::Type::Observe::ClassMethods.module_eval do
  def update_index(objects, options = {})
    Chewy.strategy(:sidekiq) { Chewy.strategy.current.update(self, objects, options) }
    true
  end
end

Chewy::Query.module_eval do
  def top_hits
    @top_hits ||= begin
      (_response['aggregations'] || {}).each_with_object({}) do |(name, data), obj|
        obj[name] = data['buckets'].each_with_object({}) do |bucket, obj2|
          hit_name = bucket.keys.find { |key| %r{_hit} =~ key }
          next if hit_name.blank?
          obj2[bucket['key']] = bucket[hit_name]['hits']['hits'].map do |hit|
            attributes = (hit['_source'] || {}).merge(hit['highlight'] || {}, &self.class.const_get(:RESULT_MERGER))
            attributes.reverse_merge!(id: hit['_id'])
              .merge!(_score: hit['_score'])
              .merge!(_explanation: hit['_explanation'])

            wrapper = _derive_index(hit['_index']).type_hash[hit['_type']].new(attributes)
            wrapper._data = hit
            wrapper
          end
        end
      end
    end
  end
end
