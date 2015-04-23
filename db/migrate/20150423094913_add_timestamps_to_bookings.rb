class AddTimestampsToBookings < ActiveRecord::Migration
  def change
    change_table :bookings do |t|
      t.timestamps
    end
  end
end
