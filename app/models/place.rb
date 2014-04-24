class Place < ActiveRecord::Base

  belongs_to :city
  belongs_to :neighborhood

  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories, :reject_if => proc { |category| category['title'].blank? }, :allow_destroy => true

  searchkick language: "Portuguese", text_middle: [:title], suggest: ['title'] , autocomplete: ['title']

  def search_data
    attributes.merge(categories: self.categories.map(&:title))
  end

  geocoded_by :full_address, :latitude => :lat, :longitude => :lon

  after_validation :geocode, :if => :address_changed?

  def full_address
    "#{address} #{number}, #{neighborhood.title}, #{city.name}"
  end
end