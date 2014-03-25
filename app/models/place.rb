class Place < ActiveRecord::Base
  searchable do
    string :title
    text :description
    latlon(:location) { Sunspot::Util::Coordinates.new(lat, lon) }

    string  :sort_title do
      title.downcase.gsub(/^(an?|the)/, '')
    end
  end
end
