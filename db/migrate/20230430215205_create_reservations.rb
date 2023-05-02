class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :number_tables, null: false
      t.string :customer_name, null: false
      t.string :customer_email, null: false
      t.date :date
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reservations, :customer_email, unique: true
  end
end
