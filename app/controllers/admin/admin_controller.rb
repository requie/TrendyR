module Admin
  # AdminController is a parent class for all controllers under Admin module
  # Do not add any actions to it, extend each controller under Admin module with it
  class AdminController < ApplicationController
    before_action :authenticate_user!, :authorize_namespace!

    private

    def authorize_namespace!
      authorize :admin, :access?
    end
  end
end
