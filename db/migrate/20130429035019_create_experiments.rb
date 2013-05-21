class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.references  :media,       null: false, polymorphic: true
      t.references  :user,        null: false

      t.string      :name,        null: false
      t.text        :description
      t.timestamps
    end
  end
end
