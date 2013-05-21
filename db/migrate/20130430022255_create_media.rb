class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.references  :user, null: false
      t.string      :type, null: false
      t.string      :name, null: false
      t.attachment  :data
      t.timestamps
    end

    add_index :media, :type
    add_index :media, :user_id
  end
end
