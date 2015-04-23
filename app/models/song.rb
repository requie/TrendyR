class Song < ActiveRecord::Base
  require 'taglib'

  belongs_to :uploader, class_name: 'User'
  belongs_to :release
  dragonfly_accessor :attachment
  before_save :set_fields

  def uploaded_by?(user)
    user == uploader
  end

  private

  def set_fields
    TagLib::FileRef.open("#{Rails.public_path}#{Dragonfly.app.remote_url_for(attachment_uid)}") do |song|
      self.title = song.tag.title
      self.duration = song.audio_properties.length
    end
  end
end
