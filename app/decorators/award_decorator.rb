class AwardDecorator < ApplicationDecorator
  def earning_year
    award.earned_at.year if award.earned_at
  end
end
