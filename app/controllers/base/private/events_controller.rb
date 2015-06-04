module Base
  module Private
    class EventsController < Private::BaseController
      include LocationProcessing

      before_action :authorize_event, only: [:index, :new, :create, :destroy]
      before_action :set_event, only: [:edit, :update]

      def index
        @events = policy_scope(Event).with_status(params[:filter]).page(params[:page])
      end

      def new
        @event = Event.new
      end

      def create
        @event = Event.new(event_params) do |event|
          event.owner_profile = @profile
          event.location = find_or_create_location
        end
        @event.save
        respond_with @event, location: private_events_path
      end

      def edit
      end

      def update
        @event.attributes = event_params
        @event.location = find_or_create_location
        @event.save
        respond_with @event, location: private_events_path
      end

      def destroy
        @profile.delete_events(destroy_events_params)
        redirect_to action: :index
      end

      private

      def authorize_event
        authorize Event
      end

      def event_params
        params.require(:event).permit(policy(Event).permitted_attributes)
      end

      def set_event
        @event = Event.find(params[:id])
        authorize @event
      end

      def destroy_events_params
        params.require(:event_ids)
      end
    end
  end
end
