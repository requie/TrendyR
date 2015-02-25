class CreateGenreProfiles < ActiveRecord::Migration
  def change
    create_join_table :genres, :profiles do |t|
      t.foreign_key :genres, dependent: :delete
      t.foreign_key :profiles, dependent: :delete
    end
  end
end
