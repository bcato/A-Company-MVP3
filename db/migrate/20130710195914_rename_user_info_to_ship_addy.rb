class RenameUserInfoToShipAddy < ActiveRecord::Migration
  def change
  	rename_table :user_info, :ship_addy
  end
end
