class RemoveRenterIdFromRentals < ActiveRecord::Migration
  def up
  	remove_column :rentals, :renter_id
  end

  def down
  	add_column :rentals, :renter_id, :integer
  end
end
