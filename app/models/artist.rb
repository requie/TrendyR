class Artist < ActiveRecord::Base
  include Rolable

  def self.batch_update(ids, values)
    ActiveRecord::Base.transaction do
      Artist.update(ids, values)
    end
  end
end
