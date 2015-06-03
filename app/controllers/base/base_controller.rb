module Base
  # BaseController is a parent class for all controllers under Base module
  # Do not add any actions to it, extend each controller under Base module with it
  class BaseController < ApplicationController
    layout 'base/main'
    respond_to :html, :json

    before_action :authenticate_user!
    before_action :authorize_namespace!
    before_action :set_profile
    before_action :set_location_for_js, only: [:index, :show]

    private

    def authorize_namespace!
      fail 'Implement namespace authorization'
    end

    def set_profile
      fail 'Implement namespace authorization'
    end

    def set_location_for_js
      gon.location = @profile.location
    end
  end
end
