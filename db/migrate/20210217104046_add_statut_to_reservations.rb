class AddStatutToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :statut, :string, default: "pending"
  end
end
