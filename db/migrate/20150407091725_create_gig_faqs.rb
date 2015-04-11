class CreateGigFaqs < ActiveRecord::Migration
  def change
    create_table :gig_faqs do |t|
      t.text :question
      t.text :answer
      t.boolean :is_active

      t.references :gig

      t.timestamps
    end
  end
end
