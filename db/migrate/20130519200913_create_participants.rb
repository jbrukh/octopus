class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|

      t.string 'firstname', :null => false
      t.string 'lastname',  :null => false
      t.string 'email',     :null => false
      t.string 'gender',    :null => false, :length => 1
      t.date 'birthday',    :null => false

      t.timestamps
    end
  end
end
