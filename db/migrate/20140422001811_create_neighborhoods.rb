class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :title
      t.integer :city_id

      t.timestamps
    end
  end
end
