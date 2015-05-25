class AddSourceToBookings < ActiveRecord::Migration
  def change
    add_column(:bookings, :source, :string)
  end
end
