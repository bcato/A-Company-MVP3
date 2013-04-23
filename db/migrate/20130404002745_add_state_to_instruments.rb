class AddStateToInstruments < ActiveRecord::Migration
  def change
  	add_column :instruments, :state, :string
  end
end
