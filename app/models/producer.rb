class Producer < ActiveRecord::Base
  include Rolable
  include Indexable

  def releases
    Release.none
  end

  def artists
    Artist.none
  end
end
