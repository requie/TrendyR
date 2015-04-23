class GigDecorator < ApplicationDecorator
  delegate_all

  def location_address
    model.location.address
  end

  def booker_name
    model.owner_profile.name
  end
end
