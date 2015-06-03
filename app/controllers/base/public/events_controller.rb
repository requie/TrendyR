module Base
  module Public
    class EventsController < Public::BaseController
      def index
        @q = @profile.owned_events.ransack(filter_params)
        @events = @q.result.includes(:location)
        @profile = @profile.decorate
      end

      private

      def filter_params
        params[:q] && params[:q].permit(policy(Event).filter_attributes)
      end
    end
  end
end
