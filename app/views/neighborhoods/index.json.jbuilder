json.array!(@neighborhoods) do |neighborhood|
  json.extract! neighborhood, :id, :title, :city_id, :integer
  json.url neighborhood_url(neighborhood, format: :json)
end
