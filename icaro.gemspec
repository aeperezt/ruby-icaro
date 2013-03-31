Gem::Specification.new do |s|
 s.name		= 'icaro' 
 s.version	= '1.0.4'
 s.date		= '2013-03-28'
 s.summary	= "Icaro Ruby Api"
 s.description	= "Ruby api for Icaro Robot"
 s.authors 	= ["Alejandro Pérez"]
 s.email	= 'alejandro.perez.torres@gmail.com' 
 s.files	= ["lib/icaro.rb"]
 s.homepage	= "http://rubygems.org/gems/icaro"
 s.add_dependency('serialport')
 s.requirements = 'serialport'
end
