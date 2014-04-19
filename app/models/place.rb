class Place < ActiveRecord::Base

  geocoded_by :address,	:latitude => :lat, :longitude => :lon
  geocoded_by :full_address, :latitude => :lat, :longitude => :lon

  after_validation :geocode, :if => :address_changed?

  searchable do
  	string :title
    string :neighborhood

    text :title
    text :description
    text :neighborhood

    latlon(:location) { Sunspot::Util::Coordinates.new(lat, lon) }
    location(:geohash) { Sunspot::Util::Coordinates.new(lat, lon) }
  end

  def full_address
    "#{address}, #{number}, #{neighborhood}, #{city}, #{state}"
  end
end