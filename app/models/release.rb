class Release < ActiveRecord::Base
  belongs_to :artist

  has_many :songs, dependent: :destroy
  belongs_to :photo, class_name: 'Release::Photo'

  before_save :set_published_at

  private

  def set_published_at
    self.published_at = DateTime.current
  end
end
