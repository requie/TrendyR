module Base
  module Public
    class BookingStepsController < Public::BaseController
      include Wicked::Wizard
      steps :overview, :payment, :confirmation

      def show
        @booking = Booking.find(session[:booking_id])
        case step
          when :overview
            @gig = @booking.gig
            render_wizard
          when :payment
            #redirect_to next_wizard_path if @booking.is_active
            @gig = @booking.gig
            gon.stripe_publishable_key = Rails.application.secrets.stripe['publishable'] #set_publishable_key
            gon.price = @booking.total_fee
            render_wizard
          when :confirmation
            render_wizard
        end
      end

      def update
        booking = Booking.find(session[:booking_id])
        case step
          when :overview
            gig = booking.gig
            render_wizard booking
          when :payment
            result = BookingChargeService.call(current_user, booking, params[:stripe_token])
            if result.success?
              booking.status = 'pending'
              booking.is_active = true
              booking.save

              booking.send_booking_notify(current_user, booking.artist.user, :created, true)

              flash[:notice] = 'Operation completed successfully'
              render_wizard booking
            else
              flash[:alert] = result.message
              redirect_to wizard_path
            end
        end
      end

    end
  end
end
