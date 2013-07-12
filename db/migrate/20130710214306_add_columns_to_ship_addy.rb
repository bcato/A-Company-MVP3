class AddColumnsToShipAddy < ActiveRecord::Migration
  def change
  	add_column :ship_addy, :address1, :string
  	add_column :ship_addy, :address2, :string
  	add_column :ship_addy, :city, :string
  	add_column :ship_addy, :state, :string
  	add_column :ship_addy, :zip, :integer
  	add_column :ship_addy, :country, :string
  end
end
