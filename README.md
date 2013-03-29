ruby-icaro
==========

Ruby api for robotica Icaro

Robot Icaro is a proyect iniciated by Valentin Basel it has a Python API. The goal of this proyect is to add a Ruby API to Icaro project.
http://roboticaicaro.org
http://www.sistema-icaro.blogspot.com/
To be able to use icaro board must be conected to the USB on you computer and you must install tortucaro first.

How to used

require 'icaro'

icaro=Icaro.new
to move robot 
 1 forward
 2 back
 3 left
 4 right
 5 stop
icaro.motor('1')
to read analog sensors
icaro.read_analgo('1')
to read digital sensors
icaro.read_digital('1')
to activate servo motors
icaro board has 5 servos 
icaro.servo('1','z')

