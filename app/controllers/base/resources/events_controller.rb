module Base
  module Resources
    class EventsController < Resources::BaseController
      def show
        @event = Event.find(params[:id])
      end
    end
  end
end
