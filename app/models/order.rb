class Order < ActiveRecord::Base
  DOLLAR = 100

  belongs_to :purchasable, polymorphic: true
  belongs_to :user

  validates :charge_id, :purchasable, :user, presence: true
  validates :purchasable_type, inclusion: { in: %w(Event Booking Cancel) }

  def charge
    return nil if charge_id.nil?
    @charge ||= Stripe::Charge.retrieve(charge_id)
  rescue Stripe::StripeError
    nil
  end

  def charge_status
    charge && charge.status.capitalize
  end

  def charge_amount
    charge && (charge.amount.to_f / DOLLAR)
  end

  def description
    if purchasable_type == 'Event'
      'Ticket purchased'
    elsif purchasable_type == 'Booking'
      'Booking request'
    elsif purchasable_type == 'Cancel'
      'Booking cancellation'
    end
  end
end
