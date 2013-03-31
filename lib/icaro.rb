#Icaro Ruby Api
#
require 'rubygems'
require 'serialport'
class Icaro

#added aliases to use the same names as the apicaro on python api

#look for the device ttyACM
#initialize the device and check if Icaro board is conected and set
# while icaro load the device may not be ready so we manage it with a rescue
# icaro board is normally recognice as a /dev/ttyACM0 how ever in some cases
# it sets on /dev/ttyACM1 so we read the device and set verify if its ready
  def initialize
	tty=Dir["/dev/ttyACM*"]
	unless tty.count==0
		tty.each do |device|	
		  begin
			@sp=SerialPort::new(device,{"baud"=>9600, "data_bits"=>8, "stop_bits"=>1, "parity"=>0})
			@sp.read_timeout=128
			@sp.write('b')
			ttyread=@sp.read
			if ttyread.include?("icaro") 
				return true
			else 	
				return false
			end
		  rescue Errno::ENODEV => ex
			STDERR.puts ex.message
	          rescue Errno::EBUSY => ex
			STDERR.puts ex.message
		  rescue Errno::EIO => ex
			STDERR.puts ex.message
		  rescue IOError => ex
			STDERR.puts ex.message
	          end		
		end
	else
		puts "Please connect Icaro"
	end 
  end

  def close 
    begin
      @sp.close
        return true
    rescue Errno::EIO => ex
        STDERR.puts ex.message
    rescue IOError => ex
        return ex
    end
  end

 alias cerrar close
# set Icaro board to ready status
# icaro=Icaro.new
# icaro.start('1')
  def start(value)
    begin
	@sp.write('s')
	@sp.write(value)
        return true
    rescue Errno::EIO => ex
        STDERR.puts ex.message
    rescue IOError => ex
        return ex
    end
  end

alias activar start

#Motor move robot DC motors 
# 1 forward
# 2 back
# 3 left
# 4 right
# 5 stop
# values are strings
# icaro.motor('1') move icaro forward
#
  def motor(value)
    if [1,2,3,4].include?(value.to_i)
     begin
	@sp.write('l')
	@sp.write(value)
        return true
     rescue Errno::EIO => ex
        STDERR.puts ex.message
     rescue IOError => ex
        return ex
     end
    else
     return false
    end
  end

#read analog input sensors
#there are 8 analog input ports
# icaro.read_analog('3')
  def read_analog(value)
     if [1,2,3,4,5,6,7,8].include?(value.to_i)
      begin
	@sp.write('e')
	@sp.write(value)
	return @sp.read
      rescue Errno::EIO => ex
        STDERR.puts ex.message
      rescue IOError => ex
        return ex
      end
     else
    	return false
     end
  end

alias leer_analogico read_analog

#read digital input sensor
#there are 4 digital input sensors ports
# d=icaro.read_digital('3')
  def read_digital(value)
    if [1,2,3,4].include?(value.to_i)
      begin
	@sp.write('d')
	@sp.write(value)
	return @sp.read==1 ? 1:0
      rescue Errno::EIO => ex
        STDERR.puts ex.message
      rescue IOError => ex
        return ex
      end
    else
      return false
    end
  end

alias leer_digital read_digital

#move servo motors
#Icaro board has 5 servo engines ports
#value is one of 255 characters and move the engine to that position
# icaro.servo('1','x')
  def servo(servo,value)
    if [1,2,3,4,5].include?(servo.to_i)
      begin
	@sp.write('m')
	@sp.write(servo)
	@sp.write(value)
	return true
      rescue Errno::EIO => ex
        STDERR.puts ex.message
      rescue IOError => ex
	return ex
      end
    else
	return false
    end
  end

alias activar_servo servo

#sound produce a sound on the port
# icaro.sound('2','2')
  def sound(audio,value)
    begin
	@sp.write('a')
	@sp.write(audio)
	@sp.write(value)
	sleep(0.01)
	@sp.write('s')
	@sp.write('0')
        return true
    rescue Errno::EIO => ex
        STDERR.puts ex.message
    rescue IOError => ex
        return ex
    end

  end

alias sonido sound
end

