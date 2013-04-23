class AddStateToRentships < ActiveRecord::Migration
  def change
  	add_column :rentships, :state, :string
  	add_index :rentships, :state
  end
end
