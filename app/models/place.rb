class Place < ActiveRecord::Base

  belongs_to :city
  belongs_to :neighborhood

  has_many :ratings

  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories, :allow_destroy => true

  searchkick language: "Portuguese", typeahead: [:title, :address], text_middle: [:title, :address], suggest: ['title', 'address'] , autocomplete: ['title', 'address']

  geocoded_by :full_address, :latitude => :lat, :longitude => :lon
  after_validation :geocode, :if => :address_changed?

  def search_data
    attributes.merge(categories: self.categories.map(&:title), rating: average_rating, neighborhood: Neighborhood.find(self.neighborhood_id).name )
  end

  def full_address
    "#{address}, #{number}, #{neighborhood.name} - #{city.name}"
  end

  def average_rating
    ratings.sum(:score) / ratings.size if ratings.size > 0
  end
end