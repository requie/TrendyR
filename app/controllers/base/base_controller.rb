module Base
  # BaseController is a parent class for all controllers under Base module
  # Do not add any actions to it, extend each controller under Base module with it
  class BaseController < ApplicationController
    layout 'base/main'
    respond_to :html, :json

    before_action :authenticate_user!, :authorize_namespace!
    before_action :set_entity
    before_action :authorize_user!
    before_action :set_profile, only: [:show, :edit, :update]
    before_action :set_location_for_js, only: [:show]

    def index
      redirect_to base_home_path(current_user.profile.id)
    end

    private

    def authorize_namespace!
      authorize :base, :access?
    end

    def set_entity
      @entity = current_user.entity
    end

    # feel free to override in children
    def authorize_user!
      true
    end

    def set_profile
      @profile = Profile.find(params[:id]).decorate
    end

    def set_location_for_js
      gon.location = @profile.location
    end
  end
end
