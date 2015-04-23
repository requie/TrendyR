module Base
  class BookingsController < Base::BaseController
    skip_before_action :set_location_for_js
    before_action :set_date, only: :index

    def index
      @gigs = current_user.profile.owned_gigs
      @calendar = @profile.entity.gigs_calendar(@date)
    end

    def create
      @booking = Booking.new(booking_params)
      @booking.artist = @profile.entity
      if @booking.save
        redirect_to base_public_profile_path(@profile), notice: 'Your booking invitation has been successfully sent'
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
      params.require(:booking).permit(:gig_id, :started_at, :finished_at)
    end
  end
end
