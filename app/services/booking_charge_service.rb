class BookingChargeService < StripeService
  def call(*params)
    customer, booking, stripe_token = params
    charge = Stripe::Charge.create(
        amount: amount(booking.total_fee, 1),
        currency: 'usd',
        source: stripe_token
    )
    order = customer.orders.create do |order|
      order.charge_id = charge.id
      order.purchasable = booking
      order.ticket_count = 1
    end
    ServiceResponse::Success.new(order)
  rescue Stripe::StripeError => e
    ServiceResponse::Error.new(e)
  end
  private

  def amount(price, count)
    (price * 100).to_i * count.to_i
  end
end

