class Photo < ActiveRecord::Base
  delegate :url, to: :attachment
end
