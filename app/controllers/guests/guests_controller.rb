module Guests
  # GuestsController is a parent class for all controllers under Guests module
  # Do not add any actions to it, extend each controller under Guests module with it
  class GuestsController < ApplicationController
    layout 'guests'

    before_action :authorize_namespace!

    private

    def authorize_namespace!
      authorize :guest, :access?
    end
  end
end
