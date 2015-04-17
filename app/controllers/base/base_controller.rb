module Base
  # BaseController is a parent class for all controllers under Base module
  # Do not add any actions to it, extend each controller under Base module with it
  class BaseController < ApplicationController
    layout 'base/main'
    respond_to :html, :json

    before_action :authenticate_user!, :authorize_namespace!
    before_action :set_entity
    before_action :authorize_user!
    before_action :set_profile
    before_action :set_location_for_js, only: [:index, :show]

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
      @profile = Profile.find_by(id: params[:profile_id]) || current_user.profile
    end

    def set_location_for_js
      gon.location = @profile.location
    end
  end
end
