class SearchIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      autocomplete: {
        type: 'custom',
        tokenizer: 'keyword',
        filter: %w(lowercase asciifolding autocomplete_filter)
      }
    },
    filter: {
      autocomplete_filter: {
        type: 'nGram',
        min_gram: 1,
        max_gram: 15,
        token_chars: %i(letter digit whitespace punctuation symbol)
      }
    }
  }

  %w(Artist Label Manager Producer Venue).each do |type|
    define_type type.constantize.includes(profile: [:location, :photo]) do
      field :id, index: 'not_analyzed'
      field :profile_id, index: 'not_analyzed'
      field :name, index: 'analyzed', value: -> { profile.name },
            index_analyzer: 'autocomplete', search_analizer: 'standard'
      field :name_length, type: 'integer', index: 'not_analyzed', value: -> { profile.name.try(:length) }
      field :address, value: ->(artist) { artist.profile.location.try(:address) }, index: 'not_analyzed'
      field :mini_logo, index: 'not_analyzed', value: -> (artist) { photo_proc(artist.profile, :mini_autocomplete) }
      field :big_logo, index: 'not_analyzed', value: -> (artist) { photo_proc(artist.profile, :big_autocomplete) }
    end
  end

  define_type Event.upcoming.includes(:owner_profile, :location, :photo), delete_if: -> { past? } do
    field :id, index: 'not_analyzed'
    field :profile_id, value: -> { owner_profile_id }, index: 'not_analyzed'
    field :name, value: -> { title }, index: 'analyzed', index_analyzer: 'autocomplete', search_analizer: 'standard'
    field :name_length, type: 'integer', index: 'not_analyzed', value: -> { title.try(:length) }
    field :address, value: ->(event) { event.location.try(:address) }, index: 'not_analyzed'
    field :mini_logo, index: 'not_analyzed', value: -> (event) { photo_proc(event, :mini_autocomplete) }
    field :big_logo, index: 'not_analyzed', value: -> (event) { photo_proc(event, :big_autocomplete) }
    field :started, type: 'date', value: -> { started_at.to_date }, index: 'not_analyzed'
    field :finished, type: 'date', value: -> { finished_at.to_date }, index: 'not_analyzed'
  end

  class << self
    def search(query, limit = 10)
      return Kaminari::PaginatableArray.new if query.nil?
      query_statement = (query.is_a? String) ? { term: { name: query.to_s.downcase } } : query
      query(query_statement).query_mode(:must).order(name_length: :asc).limit(limit)
    end

    def search_grouped_by_type(query, limit = 10)
      return Kaminari::PaginatableArray.new if query.nil?
      search(query).aggregations(
        type: {
          terms: { field: '_type' },
          aggs: {
            top_type_hits: {
              top_hits: { size: limit }
            }
          }
        }
      ).top_hits['type']
    end

    def photo_proc(model, type)
      model.photo && model.photo.with_presets([:cropped, type])
    end
  end
end
