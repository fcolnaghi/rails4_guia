class Place < ActiveRecord::Base

  geocoded_by :address,
  	:latitude => :lat, :longitude => :lon
  geocoded_by :q
  after_validation :geocode

  searchable do
  	string :title
    text :title
    text :description
    latlon(:location) { Sunspot::Util::Coordinates.new(lat, lon) }
    location(:geohash) { Sunspot::Util::Coordinates.new(lat, lon) }
  end
end
