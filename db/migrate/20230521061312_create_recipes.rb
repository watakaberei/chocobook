class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :customer_id, null: false
      t.integer :category_id, null: false
      t.string :name, null: false
      t.string :introduction, null: false
      t.integer :cooktime, null: false
      t.string :image, null: false
      t.string :material, null: false
      t.integer :quantity, null: false
      t.text :procedure, null: false
      t.timestamps
    end
  end
end
