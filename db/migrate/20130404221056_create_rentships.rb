class CreateRentships < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
    	t.integer :user_id
    	t.integer :renter_id
      	t.timestamps
    end

    add_index :rentals, [:user_id, :renter_id]
  end
end
