module Guests
  class SubscriptionsController < GuestsController
    def create
      @subscription = Subscription.new(subscription_params)
      if @subscription.save
        flash[:notice] = "Thank You For Subscribing!"
      else
        flash[:alert] = @subscription.errors.full_messages
      end
      redirect_to :back
    end

    private

    def subscription_params
      params.require(:subscription).permit(:email)
    end
  end
end