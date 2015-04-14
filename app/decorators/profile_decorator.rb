class ProfileDecorator < ApplicationDecorator
  delegate_all

  def name_placeholder
    "#{model.entity.class.name} Name"
  end
end
