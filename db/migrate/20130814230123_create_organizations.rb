class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string  :name,      :null => false
      t.timestamps
    end

    add_column :users, :organization_id, :integer, :null => true
    add_index :users, [:organization_id]
  end
end
