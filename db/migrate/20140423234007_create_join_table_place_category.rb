class CreateJoinTablePlaceCategory < ActiveRecord::Migration
  def change
    create_join_table :places, :categories do |t|
       #t.index [:place_id, :category_id]
       #t.index [:category_id, :place_id]
    end
  end
end
