class Place < ActiveRecord::Base

  belongs_to :city
  belongs_to :neighborhood

  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories, :reject_if => proc { |category| category['title'].blank? }, :allow_destroy => true

  searchkick language: "Portuguese", text_middle: [:title, :address], suggest: ['title', 'address'] , autocomplete: ['title', 'address']

  geocoded_by :full_address, :latitude => :lat, :longitude => :lon

  after_validation :geocode, :if => :address_changed?

  def search_data
    attributes.merge(categories: self.categories.map(&:title))
  end

  def full_address
    bairro = "#{neighborhood.title}" unless neighborhood.nil? 
    bairro ||= 'ERRO AO CARREGAR BAIRRO'
    cidade = "#{city.name}" unless city.nil? 
    "#{address}, #{number}, #{bairro} - #{cidade}"
  end
end