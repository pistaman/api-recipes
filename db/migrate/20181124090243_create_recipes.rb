class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title, :null => false
      t.string :making_time, :null => false
      t.string :serves, :null => false
      t.string :ingredients, :null => false
      t.integer :cost, :null => false
      t.timestamps null: false
    end
  end
end
