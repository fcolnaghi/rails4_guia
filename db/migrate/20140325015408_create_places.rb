class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :title
      t.text :description
      t.float :lat, null: true
      t.float :lon, null: true

      t.timestamps
    end
  end
end
