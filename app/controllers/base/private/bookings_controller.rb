module Base
  module Private
    class BookingsController < Private::BaseController
      def index
        @bookings = @profile.entity.bookings.includes(gig: :location).page(params[:page]).decorate
      end

      def request_confirmation
        gig = Gig.find(params[:id])
        authorize gig
        @booking = Booking.new(source: 'request') do |record|
          record.gig = gig
          record.artist = @profile.entity
        end
        @booking.save!
        render nothing: true
      end

      def state
        booking = Booking.find(params[:id])
        authorize booking
        state = booking.pending? && booking.update_attribute(:status, params[:status])
        head status: (state ? :ok : :unprocessable_entity)
      end
    end
  end
end
