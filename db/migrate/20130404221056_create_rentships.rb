class CreateRentships < ActiveRecord::Migration
  def change
    create_table :rentships do |t|
    	t.integer :user_id
    	t.integer :renter_id
      	t.timestamps
    end

    add_index :rentships, [:user_id, :renter_id]
  end
end
