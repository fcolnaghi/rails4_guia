class AddNumberAndNeighborhoodAndCategoryToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :number, :string
    add_column :places, :category, :integer
    add_column :places, :neighborhood_id, :integer
    add_column :places, :city_id, :integer
  end
end
