class AddCityAndStateAndCepToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :state, :string
    add_column :places, :cep, :string
  end
end
