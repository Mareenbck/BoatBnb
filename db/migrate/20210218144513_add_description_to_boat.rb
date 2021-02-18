class AddDescriptionToBoat < ActiveRecord::Migration[6.0]
  def change
    add_column :boats, :description, :string
  end
end
