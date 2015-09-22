module Base
  module Private
    class BookingsController < Private::BaseController
      def index
        @bookings = @profile.entity.user.bookings.active.includes(gig: :location).page(params[:page]).decorate
        if @profile.user.role.name == 'artist'
          @my_bookings = Booking.where(artist_id: @profile.user.id).active.includes(gig: :location).page(params[:page]).decorate
        end
      end

      # Создаёт новый буукинг и сохраняет
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

      def cancel_booking_request
        booking = Booking.find(params[:id])
        result = BookingRefundService.call(current_user, booking)
        if result.success?
          booking.status = 'rejected'
          #booking.is_active = false
          booking.save
          booking.send_booking_notify(current_user, booking.artist.user, :rejected, true)

          flash[:notice] = 'Booking has been rejected. $7.99 is charged to cancellation.'
        else
          flash[:alert] = result.message
        end
        redirect_to action: :index
      end

      def state
        booking = Booking.find(params[:id])
        state = booking.update_attribute(:status, params[:status]) && ( booking.pending? || booking.user == current_user )
        head status: (state ? :ok : :unprocessable_entity)

        booking.send_booking_notify(booking.artist.user, booking.user, :"#{params[:status]}", true)
        #redirect_to action: :index
      end

    end
  end
end
