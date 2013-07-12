class ChangeColumnsInShipAddyTable < ActiveRecord::Migration
  def up
  	remove_column :ship_addy, :liner, :string
  	remove_column :ship_addy, :fav_I, :string
  	remove_column :ship_addy, :fav_band, :string
  	remove_column :ship_addy, :cur_learn, :string
  	remove_column :ship_addy, :other, :string
  end

  def down
  	add_column :ship_addy, :address1, :string
  	add_column :ship_addy, :address2, :string
  	add_column :ship_addy, :city, :string
  	add_column :ship_addy, :state, :string
  	add_column :ship_addy, :zip, :integer
  	add_column :ship_addy, :country, :string
  end
end
