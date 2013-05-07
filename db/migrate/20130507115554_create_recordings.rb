class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.references  :user, null: false
      t.timestamps
    end
  end
end
