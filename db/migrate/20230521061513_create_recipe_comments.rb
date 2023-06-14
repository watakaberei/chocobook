class CreateRecipeComments < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_comments do |t|
      t.string :customer_id
      t.string :recipe_id
      t.text :comment
      t.timestamps
    end
  end
end
