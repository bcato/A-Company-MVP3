class AddDatesToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :start_on, :date
    add_column :rentals, :end_on, :date
    add_column :rentals, :instrument_id, :integer
  end
end
