class BookingPolicy
  attr_reader :user, :booking

  def initialize(user, booking)
    @user = user
    @booking = booking
  end

  def state?
    booking.artist == user.entity
  end
end
