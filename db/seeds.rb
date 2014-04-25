# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# File.open("db/anuncios.yml", 'r') do |file|
#         YAML::load(file).each do |record|
# 	  		Place.create(
# 	  			title: record['nome'],
# 				description: record['keywords']	,
# 				address: record['endereco'],
# 				neighborhood: record['bairro'],
# 				number: record['numero'],
# 				city: record['cidade'],
# 				state: record['estado'],
# 				cep: record['cep']
# 			)
#         end
# end

# 100 restaurantes
20.times do
	Place.create(
	title: Faker::Company.name,
	address: Faker::Address.street_name,
	neighborhood_id: 2,
	number: Faker::Address.building_number,
	city_id: "1",
	state: "PR",
	cep: Faker::Address.zip_code,
	category_ids: [1, rand(5)+1])
end

20.times do
	Place.create(
	title: Faker::Company.name,
	address: Faker::Address.street_name,
	neighborhood_id: 2,
	number: Faker::Address.building_number,
	city_id: "1",
	state: "PR",
	cep: Faker::Address.zip_code,
	category_ids: [6])
end

# 100.times do
# 	Place.create(
# 	title: Faker::Company.name,
# 	address: Faker::Address.street_name,
# 	neighborhood_id: "1",
# 	number: Faker::Address.building_number,
# 	city_id: "1",
# 	state: "PR",
# 	cep: Faker::Address.zip_code,
# 	category_ids: [Category.last])
# end

