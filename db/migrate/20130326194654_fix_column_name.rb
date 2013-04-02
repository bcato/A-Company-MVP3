class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :instruments, :type, :category
  end
end
