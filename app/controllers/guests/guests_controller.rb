module Guests
  # GuestsController is a parent class for all controllers under Guests module
  # Do not add any actions to it, extend each controller under Guests module with it
  class GuestsController < ApplicationController
    layout 'guests/main'

    before_action :authorize_namespace!
    before_action :set_profile, if: -> { user_signed_in? }

    private

    def authorize_namespace!
      authorize :guest, :access?
    end

    def set_profile
      @profile = current_user.profile
    end
  end
end
