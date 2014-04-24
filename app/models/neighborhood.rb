class Neighborhood < ActiveRecord::Base
	belongs_to :city
	has_many :places
	
	searchkick language: "Portuguese", text_start: [:title], suggest: ['title'] , autocomplete: ['title']
end
