class AddNumberAndNeighborhoodAndCategoryToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :number, :string
    add_column :places, :neighborhood, :string
    add_column :places, :category, :integer
  end
end
