Gem::Specification.new do |s|
 s.name		= 'icaro' 
 s.version	= '1.0.5'
 s.date		= '2013-04-01'
 s.summary	= "Icaro Ruby Api"
 s.description	= "Ruby api for Icaro Robot"
 s.authors 	= ["Alejandro Pérez"]
 s.email	= 'alejandro.perez.torres@gmail.com' 
 s.files	= ["lib/icaro.rb"]
 s.homepage	= "http://rubygems.org/gems/icaro"
 s.add_dependency('serialport')
 s.requirements = 'serialport'
end
