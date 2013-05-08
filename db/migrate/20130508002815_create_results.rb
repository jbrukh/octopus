class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :duration, null: false
      t.timestamps
    end
  end
end
