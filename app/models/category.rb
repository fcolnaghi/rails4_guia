class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Category', :foreign_key => 'category_id'
  has_many :children, :class_name => 'Category', :foreign_key => 'category_id'

  searchable do
  	string :title
    text :title
  end

  def children?
  	not self.children.empty?
  end

  def parent?
  	not self.parent.nil?
  end
end
