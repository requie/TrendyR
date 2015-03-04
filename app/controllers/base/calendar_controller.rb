module Base
  class CalendarController < Base::BaseController
    def show
      authorize @profile
    end
  end
end
