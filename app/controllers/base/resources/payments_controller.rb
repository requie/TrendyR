module Base
  module Resources
    class PaymentsController < Resources::BaseController
      before_action :set_publishable_key, only: :event_form

      SEARCH_ATTRIBUTES = %w(created_at_gteq created_at_lteq charge_id_cont)

      def index
        @q = current_user.orders.ransack(search_params)
        @orders = @q.result.page(params[:page]).per(20)
      end

      def event_form
        @event = Event.find(params[:id]).decorate
        gon.price = @event.price
      end

      def event_charge
        event = Event.find(params[:id])
        result = TicketChargeService.call(current_user, event, params[:ticket_count], params[:stripe_token])
        if result.success?
          redirect_to({ action: :index }, notice: 'Operation completed successfully')
        else
          redirect_to({ action: :event_form }, alert: result.message)
        end
      end

      private

      def set_publishable_key
        gon.stripe_publishable_key = Rails.application.secrets.stripe['publishable']
      end

      def search_params
        params[:q] && params[:q].permit(SEARCH_ATTRIBUTES)
      end
    end
  end
end
