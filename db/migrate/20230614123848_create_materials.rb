class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.string :name, null: false
      t.integer :amount, null: false
      t.timestamps
    end
  end
end
