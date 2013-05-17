class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :recording,  null: false
      t.references :user,       null: false

      t.string :name,           null: false
      t.integer :from_ms,       null: false
      t.integer :to_ms,         null: false

      t.timestamps
    end
  end
end