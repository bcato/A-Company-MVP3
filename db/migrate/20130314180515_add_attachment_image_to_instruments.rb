class AddAttachmentImageToInstruments < ActiveRecord::Migration
  def self.up
    change_table :instruments do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :instruments, :image
  end
end
