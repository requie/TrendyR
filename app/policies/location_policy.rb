class LocationPolicy
  PERMITTED_ATTRIBUTES = %i(source source_id source_place_id address types latitude longitude)
  attr_reader :user, :location

  def initialize(user, location)
    @user = user
    @location = location
  end

  def permitted_attributes
    PERMITTED_ATTRIBUTES
  end
end
