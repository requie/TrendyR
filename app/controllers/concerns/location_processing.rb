module LocationProcessing
  extend ActiveSupport::Concern

  def find_or_create_location
    Location.find_or_create_by(source_place_id: params[:source_place_id]) do |l|
      l.assign_attributes(location_params)
    end
  end

  private

  def location_params
    params.require(:location).permit(*policy(:location).permitted_attributes)
  end
end
