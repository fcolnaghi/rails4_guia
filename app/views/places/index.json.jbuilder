json.array!(@places) do |place|
  json.extract! place, :title, :description, :lat, :log
  json.url place_url(place, format: :json)
end
