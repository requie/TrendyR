module Base
  module Resources
    class EventsController < Resources::BaseController
      def show
        @event = Event.find(params[:id])
        @comments = @event.comments.recent.all
      end
    end
  end
end