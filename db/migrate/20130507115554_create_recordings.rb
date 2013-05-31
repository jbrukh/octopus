class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.references  :user,       null: false
      t.references  :participant

      t.string      :session_id, null: false
      t.string      :state,      null: false

      t.text        :name
      t.text        :description
      t.integer     :duration_ms

      t.attachment  :data

      t.datetime    :trashed_at
      t.timestamps
    end
  end
end
