class AwardDecorator < ApplicationDecorator
  delegate_all

  def earning_year
    model.earned_at.year if model.earned_at
  end
end
