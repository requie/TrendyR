class CreateGigFaqs < ActiveRecord::Migration
  def change
    create_table :gig_faqs do |t|
      t.text :question
      t.text :answer
      t.boolean :is_active

      change_references(t)

      t.timestamps
    end
  end

  def change_references(t)
    t.references :gig
  end
end
