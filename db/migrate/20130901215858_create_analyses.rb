class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.references  :user,          :null => false
      t.references  :recording,     :null => false

      t.integer :jid,          :null => false
      t.string  :state,           :null => false

      t.string  :algorithm,      :null => false
      t.hstore  :arguments,      :null => false

      t.timestamps
    end
  end
end
