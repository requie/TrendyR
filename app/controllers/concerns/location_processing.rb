module LocationProcessing
  extend ActiveSupport::Concern

  def create_location
    Location.find_or_create_by(location_params) do |l|
      l.creator = @profile.user
    end
  end

  def location_params
    params.require(:location).permit(*policy(:location).permitted_attributes)
  end
end
