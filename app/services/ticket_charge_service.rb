class TicketChargeService < StripeService
  def call(*params)
    customer, event, ticket_count, stripe_token = params
    charge = Stripe::Charge.create(
      amount: amount(event.price, ticket_count),
      currency: 'usd',
      source: stripe_token
    )
    order = customer.orders.create do |order|
      order.charge_id = charge.id
      order.purchasable = event
      order.ticket_count = ticket_count
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
