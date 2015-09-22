module Base
  module Public
    class BookingsController < Public::BaseController
      before_action :set_date, only: :index

      def index
        @gigs = current_user.profile.owned_gigs
        @events = current_user.profile.owned_events
        @calendar = @profile.entity.gigs_calendar(@date)
      end

      def create_new_gig
        session[:redirect_to_booking] = @profile.id
        redirect_to new_private_gig_path
      end

      def create
        gig = Gig.find(booking_params[:gig_id])
        @booking = Booking.new(booking_params) do |booking|
          booking.source = 'request'
          booking.artist = @profile.entity
          booking.user = current_user
          booking.gig_title = gig.title
          booking.total_fee = gig.price
          booking.started_at = gig.started_at
          booking.finished_at = gig.finished_at
        end
        if @booking.save
          session[:booking_id] = @booking.id
          redirect_to public_profile_booking_steps_path
        else
          redirect_to({ action: :index }, alert: 'Booking failed')
        end
      end

      private

      def set_date
        @date = begin
          Date.parse(params[:date])
        rescue
          Date.current
        end
      end

      def booking_params
        params.require(:booking).permit(:gig_id, :payout_option)
      end
    end
  end
end
