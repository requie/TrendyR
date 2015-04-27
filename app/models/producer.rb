class Producer < ActiveRecord::Base
  include Rolable

  def releases
    Release.none
  end
end
