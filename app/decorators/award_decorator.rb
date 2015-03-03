class AwardDecorator < ApplicationDecorator
  def earning_year
    object.earned_at.year if object.earned_at
  end
end
