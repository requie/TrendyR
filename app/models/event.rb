class Event < ActiveRecord::Base
  include Ownable
  include Locationable

  scope :upcoming, -> { where("finished_at > ?", Date.today).order("started_at") }

  belongs_to :photo, class_name: 'Event::Photo'
  validates :title, :description_text, :started_at, :finished_at, :photo, presence: true
end
