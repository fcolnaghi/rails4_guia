class RemoveCategotyFromPlaces < ActiveRecord::Migration
  def change
    remove_column :places, :category, :integer
  end
end
