class AddUserIdToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :user_id, :integer
    add_index :instruments, :user_id
  end
end
