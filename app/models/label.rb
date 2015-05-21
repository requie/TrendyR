class Label < ActiveRecord::Base
  include Rolable
  include Indexable

  def releases
    Release.none
  end
end
