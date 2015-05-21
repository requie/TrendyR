module Guests
  class StaticPagesController < Guests::GuestsController
    def index
      render params[:page]
    end
  end
end
