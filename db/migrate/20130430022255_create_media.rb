class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.attachment :data
      t.timestamps
    end

    add_index :media, :type
  end
end
