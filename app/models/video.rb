class Video < ActiveRecord::Base
  belongs_to :uploader, class_name: 'User'
end
