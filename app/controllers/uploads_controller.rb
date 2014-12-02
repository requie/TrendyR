class UploadsController < ApplicationController
  def index
    @profiles = Profile.all.decorate
    @profile = Profile.new
    @profile.build_wallpaper
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to action: :index
    else
      render action: :index
    end
  end

  private

  def profile_params
    params.require(:profile).permit(wallpaper_attributes: [:attachment])
  end
end
