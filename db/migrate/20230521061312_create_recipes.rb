class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :introduction, null: false
      t.string :cooktime, null: false
      t.boolean :is_draft, default: false, null: false
      t.timestamps
    end
  end
end
