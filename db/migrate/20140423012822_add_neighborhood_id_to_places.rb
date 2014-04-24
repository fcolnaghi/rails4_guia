class AddNeighborhoodIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :neighborhood_id, :integer
    add_column :places, :city_id, :integer

    remove_column :places, :neighborhood, :integer
    remove_column :places, :city, :integer
  end
end
