module Indexable
  extend ActiveSupport::Concern

  included do
    update_index("search##{self.to_s.downcase}") { self }
  end
end
