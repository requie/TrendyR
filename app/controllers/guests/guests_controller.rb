module Guests
  # GuestsController is a parent class for all controllers under Guests module
  # Do not add any actions to it, extend each controller under Guests module with it
  class GuestsController < ApplicationController
    layout 'guests/main'

    before_action :authorize_namespace!
    before_action :set_profile, if: proc { user_signed_in? }
    before_action :set_inbox_messages, if: proc { user_signed_in? && !request.xhr? }

    private

    def set_profile
      @profile = current_user.profile
    end

    def set_inbox_messages
      @inbox_messages = current_user.unread_messages
    end

    def authorize_namespace!
      authorize :guest, :access?
    end
  end
end
