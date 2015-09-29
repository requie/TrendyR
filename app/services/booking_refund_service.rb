class BookingRefundService < StripeService
  def call(*params)

    customer, booking = params
    charge = Order.find_by_purchasable_id(booking.id).charge
    re = Stripe::Refund.create(
        charge: charge.id,
        amount: cancel_amount(charge.amount, 7.99)
    )
    ServiceResponse::Success.new(re)
  rescue Stripe::StripeError => e
    ServiceResponse::Error.new(e)
  end
  private

  def cancel_amount(amount, delta)
    amount - (delta*100).to_i
  end
end

