module Indexable
  extend ActiveSupport::Concern

  included do
    update_index("search##{to_s.downcase}") { self }
  end
end
