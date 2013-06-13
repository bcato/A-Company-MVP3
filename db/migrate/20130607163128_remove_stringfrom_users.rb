class RemoveStringfromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :liner, :string
  	remove_column :users, :fav_I, :string
  	remove_column :users, :fav_band, :string
  	remove_column :users, :cur_learn, :string
  	remove_column :users, :other, :string
  end
  
end
