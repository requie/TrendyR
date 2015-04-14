class Award < ActiveRecord::Base
  include Ownable

  validates :title, :description_text, :earned_at, presence: true

  def earning_year
    earned_at.try(:year)
  end

  def self.start_year
    Date.today.year
  end

  def self.end_year
    Date.today.year - 90
  end
end
