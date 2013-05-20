class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.references  :user,    null: false

      t.string      :first_name, :null => false
      t.string      :last_name,  :null => false
      t.string      :email,      :null => false
      t.string      :gender,     :null => false, :length => 1
      t.date        :birthday,   :null => false

      t.hstore      :properties

      t.datetime    :trashed_at
      t.timestamps
    end

    add_index :participants, [:email], :unique => true
  end
end
