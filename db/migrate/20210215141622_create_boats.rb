class CreateBoats < ActiveRecord::Migration[6.0]
  def change
    create_table :boats do |t|
      t.string :name
      t.integer :price
      t.string :localisation
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.integer :capacity

      t.timestamps
    end
  end
end
