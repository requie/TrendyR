class AddColumnsToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :started_at, :datetime
    add_column :bookings, :finished_at, :datetime
    add_column :bookings, :is_active, :boolean, default: false
  end
end
