class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string  :name,      :null => false
      t.integer :owner_id,  :null => false

      t.timestamps
    end

    add_index :organizations, [:owner_id]
  end
end
