class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.boolean :status

      t.timestamps
    end
  end
end
