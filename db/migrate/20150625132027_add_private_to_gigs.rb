class AddPrivateToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :private, :boolean, default: false
  end
end
