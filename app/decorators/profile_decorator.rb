class ProfileDecorator < ApplicationDecorator
  delegate_all

  def location_address
    object.location.address if object.location
  end

  def name_placeholder
    "#{object.entity.class.name} Name"
  end
end
