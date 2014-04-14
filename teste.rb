require 'yaml'
File.open("db/anuncios.yml", 'r') do |file| 
	YAML::load(file).each do |record| 
		print record['endereco'] 
		puts record['bairro']
	end
end
