class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent_id'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'
  has_and_belongs_to_many :places

  searchkick language: "Portuguese", text_start: [:title], suggest: ['title'] , autocomplete: ['title']

  def as_json options={}
  {
    id: id,
    title: title
  }
  end

  def children?
  	not self.children.empty?
  end

  def parent?
  	not self.parent.nil?
  end
end
