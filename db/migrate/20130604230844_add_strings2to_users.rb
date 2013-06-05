class AddStrings2toUsers < ActiveRecord::Migration
  def change
  	add_column :users, :liner, :string
  	add_column :users, :fav_I, :string
  	add_column :users, :fav_band, :string
  	add_column :users, :cur_learn, :string
  	add_column :users, :other, :string
  end

end
