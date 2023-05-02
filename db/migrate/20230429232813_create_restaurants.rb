class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.text :description
      t.string :address, null: false
      t.string :city, null: false
      t.string :photo, null: false

      t.timestamps
    end
    add_index :restaurants, :name, unique: true
  end
end
