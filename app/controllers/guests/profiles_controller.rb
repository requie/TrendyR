module Guests
  class LandingController < GuestsController
    def show
      @profile = @profile.decorate
    end
  end
end