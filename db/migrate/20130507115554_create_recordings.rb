class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.references  :user,    null: false
      t.references  :result

      t.string      :state,   null: false

      t.text        :description
      t.integer     :duration_ms

      t.datetime    :trashed_at
      t.timestamps
    end
  end
end
