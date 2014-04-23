class Place < ActiveRecord::Base

  belongs_to :city
  belongs_to :neighborhood

  has_many :categories

  searchkick language: "Portuguese", text_start: [:title], suggest: ['title'] , autocomplete: ['title']

  geocoded_by :address,	:latitude => :lat, :longitude => :lon
  geocoded_by :full_address, :latitude => :lat, :longitude => :lon

  after_validation :geocode, :if => :address_changed?

  def full_address
    "#{address} #{number}, #{neighborhood.title}, #{city.name}"
  end
end