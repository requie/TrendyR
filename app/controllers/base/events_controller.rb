module Base
  class EventsController < Base::BaseController
    def show
      authorize @profile
    end
  end
end
