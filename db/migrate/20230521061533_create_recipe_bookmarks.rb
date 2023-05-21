class CreateRecipeBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_bookmarks do |t|
      t.string :customer_id
      t.string :recipe_id
      t.timestamps
    end
  end
end
