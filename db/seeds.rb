# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
File.open("db/anuncios.yml", 'r') do |file|
        YAML::load(file).each do |record|
	  		Place.create(
	  			title: record['nome'],
				description: record['keywords']	,
				address: record['endereco'],
				neighborhood: record['bairro'],
				number: record['numero'],
				city: record['cidade'],
				state: record['estado'],
				cep: record['cep']
			)
        end
end

