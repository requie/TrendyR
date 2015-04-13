class ProfileDecorator < ApplicationDecorator
  delegate_all
  decorates_association :owned_awards

  def name_placeholder
    "#{model.entity.class.name} Name"
  end
end
