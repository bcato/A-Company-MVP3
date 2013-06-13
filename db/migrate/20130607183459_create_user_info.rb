class CreateUserInfo < ActiveRecord::Migration
  
  def change
    create_table :user_info do |t|
      t.integer :user_id
      t.string :liner
      t.string :fav_I
      t.string :fav_band
      t.string :cur_learn
      t.string :description

      t.timestamps
    end

  add_index :user_info, [:user_id]
  
  end

end


