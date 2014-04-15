class Place < ActiveRecord::Base

  geocoded_by :address,
  	:latitude => :lat, :longitude => :lon
<<<<<<< HEAD
  geocoded_by :full_address,
    :latitude => :lat, :longitude => :lon

  after_validation :geocode , :if => :address_changed?
=======
  #geocoded_by :q
  after_validation :geocode
>>>>>>> effe3a58108ea5eb21aec807ebdf0943bc39f90e

  searchable do
  	string :title
    string :neighborhood
    text :title
    text :description
    latlon(:location) { Sunspot::Util::Coordinates.new(lat, lon) }
    location(:geohash) { Sunspot::Util::Coordinates.new(lat, lon) }
  end

  def full_address
    "#{address}, #{number}, #{neighborhood}, #{city}, #{state}"
  end
end
