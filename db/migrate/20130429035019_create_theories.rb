class CreateTheories < ActiveRecord::Migration
  def change
    create_table :theories do |t|

      t.timestamps
    end
  end
end
