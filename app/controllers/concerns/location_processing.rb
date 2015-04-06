module LocationProcessing
  extend ActiveSupport::Concern

  def create_location(model)
    location = Location.find_or_create_by(location_params) do |l|
      l.creator = @profile.user
    end
    model.location = location
  end

  def location_params
    params.require(:location).permit(*policy(:location).permitted_attributes)
  end
end
