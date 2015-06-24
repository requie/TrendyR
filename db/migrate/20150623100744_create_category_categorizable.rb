class CreateCategoryCategorizable < ActiveRecord::Migration
  def change
    create_table :category_categorizables do |t|
      t.references :categorizable, polymorphic: true
      t.references :category, index: true
      t.index [:categorizable_id, :categorizable_type],
              name: 'index_category_categorizables_on_categorizable_id_type'

      t.timestamps null: false
    end
  end
end
