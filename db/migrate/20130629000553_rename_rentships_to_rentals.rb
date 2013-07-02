class RenameRentshipsToRentals < ActiveRecord::Migration
  def change
  	rename_table :rentals, :rentals
  end
end
