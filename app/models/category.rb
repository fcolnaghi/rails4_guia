class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Category', :foreign_key => 'category_id'
  has_many :children, :class_name => 'Category', :foreign_key => 'category_id'
  
  searchkick text_start: [:title], suggest: ['title'] , autocomplete: ['title']

  def children?
  	not self.children.empty?
  end

  def parent?
  	not self.parent.nil?
  end
end
