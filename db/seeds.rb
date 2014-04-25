# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# File.open("db/restaurantes.yml", 'r') do |file|
# 	YAML::load(file).each do |record|
# 		search = Neighborhood.search("#{record['bairro']}", order: {title: :asc} )
# 		bairro = search.first
# 		puts "#{record['nome'].titleize()} #{record['endereco'].titleize()}"
# 		# if record['bairro'] == 'CENTRO'
# 		# 	puts "#{record['idanuncio']} - BAIRRO ([#{record['bairro']}:#{bairro.title}][#{bairro.id}])"
# 		# else
# 		# 	puts "#{record['idanuncio']} - BAIRRO (#{record['bairro']}) = NÃO IDENFICADO"
# 		# end
# 	end
# end



File.open("db/restaurantes.yml", 'r') do |file|
	arquivo = YAML::load(file)
	bar = ProgressBar.new(arquivo.count)
	arquivo.each do |record|
		search = Neighborhood.search("#{record['bairro']}", order: {title: :asc} )
		bairro = search.first
		Place.create(
			neighborhood_id: bairro.id,
			city_id: "1",
			state: "PR",
			category_ids: [1],
			title: record['nome'].titleize(),
			address: record['endereco'].titleize(),
			number: record['numero'],
			cep: record['cep']
		)
		bar.increment!
	end
end

# 100 restaurantes
=begin

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
=end


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

