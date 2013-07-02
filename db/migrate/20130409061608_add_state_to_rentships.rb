class AddStateToRentships < ActiveRecord::Migration
  def change
  	add_column :rentals, :state, :string
  	add_index :rentals, :state
  end
end
