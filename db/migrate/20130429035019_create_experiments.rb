class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string      :name,        null: false
      t.text        :description
      t.references  :media,       polymorphic: true, null: false
      t.timestamps
    end
  end
end
