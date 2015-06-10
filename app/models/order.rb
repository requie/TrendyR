class Order < ActiveRecord::Base
  DOLLAR = 100

  belongs_to :purchasable, polymorphic: true
  belongs_to :user

  validates :charge_id, :purchasable, :user, presence: true
  validates :purchasable_type, inclusion: { in: %w(Event) }

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
    else
      'Unknown type'
    end
  end
end
