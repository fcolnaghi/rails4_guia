class Neighborhood < ActiveRecord::Base
	belongs_to :city
	has_many :places

	searchkick text_start: [:name], suggest: ['name'], autocomplete: ['name']
end
