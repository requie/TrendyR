class Award < ActiveRecord::Base
  include Ownable
  scope :ordered, -> { order(:earned_at) }

  validates :title, :description_text, :earned_at, presence: true

  def self.start_year
    Date.today.year
  end

  def self.end_year
    Date.today.year - 90
  end
end
