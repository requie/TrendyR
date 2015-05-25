class AddEventReferenceToGigs < ActiveRecord::Migration
  def change
    change_table :gigs do |t|
      t.references :event
    end
  end
end
