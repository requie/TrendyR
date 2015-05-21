class Manager < ActiveRecord::Base
  include Rolable
  include Indexable
end
