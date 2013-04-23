class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.integer :user_id
      t.integer :renter_id
      t.string :description

      t.timestamps
    end
  end
end
