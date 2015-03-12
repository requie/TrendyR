class AwardDecorator < ApplicationDecorator
  delegate_all

  def earning_year
    object.earned_at.year if object.earned_at
  end
end
