class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string      :state,   null: false
      t.references  :user,    null: false
      t.references  :result
      t.timestamps
    end
  end
end
