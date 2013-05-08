class AddAttachmentDataToResults < ActiveRecord::Migration
  def self.up
    change_table :results do |t|
      t.attachment :data
    end
  end

  def self.down
    drop_attached_file :results, :data
  end
end
