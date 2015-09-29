class AddPayoutOptionToBooking < ActiveRecord::Migration
  def change
    change_table :bookings do |t|
      t.string :payout_option
      t.decimal :total_fee, :precision => 8, :scale => 2
      t.string :gig_title
      t.references :user
      t.references :event
      t.foreign_key :events, dependent: :delete
    end
  end
end
