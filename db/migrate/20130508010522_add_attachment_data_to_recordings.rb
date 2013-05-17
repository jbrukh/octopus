class AddAttachmentDataToRecordings < ActiveRecord::Migration
  def self.up
    change_table :recordings do |t|
      t.attachment :data
    end
  end

  def self.down
    drop_attached_file :recordings, :data
  end
end
