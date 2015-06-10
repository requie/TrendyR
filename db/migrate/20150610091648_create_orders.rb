class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :charge_id, default: ''
      t.integer :ticket_count
      t.belongs_to :purchasable, polymorphic: true, index: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
