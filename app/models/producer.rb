class Producer < ActiveRecord::Base
  include Rolable

  def releases
    Release.none
  end

  def artists
    Artist.none
  end
end
