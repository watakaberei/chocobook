class CreateRecipeBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_bookmarks do |t|
      t.integer :customer_id
      t.integer :recipe_id
      t.timestamps
    end
  end
end
