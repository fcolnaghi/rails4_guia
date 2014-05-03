class HomeController < ApplicationController
  def index
  	@top10 = Place.search("*", facets: [:neighborhood, :rating, :categories, :city_id], limit: 10 , order: { rating: :desc } )
  end
end
