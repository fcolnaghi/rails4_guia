class RemoveCategotyIdFromPlaces < ActiveRecord::Migration
  def change
    remove_column :places, :category_id, :integer
  end
end
