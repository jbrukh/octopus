class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.references  :user,          :null => false
      t.references  :experiment,    :null => false
      t.references  :participant,   :null => false

      t.text        :description

      t.timestamps
    end
  end
end
