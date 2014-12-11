module Base
  # BaseController is a parent class for all controllers under Base module
  # Do not add any actions to it, extend each controller under Base module with it
  class BaseController < ApplicationController
    before_action :authenticate_user!, :authorize_namespace!
    before_action :set_entity
    before_action :authorize_user!

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
  end
end
