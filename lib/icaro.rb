#Icaro Ruby Api
#
require 'rubygems'
require 'serialport'
class Icaro
#look for the device ttyACM
#initialize the device and check if Icaro board is conected and set
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
				icaro=device
				return true
			else 	
				icaro=''
				return false
			end
		  rescue Errno::ENODEV => ex
			STDERR.puts ex.message
	          rescue Errno::EBUSY => ex
			STDERR.puts ex.message
		  rescue IOError => ex
			STDERR.puts ex.message
	          end		
		end
	else
		icaro=''
		puts "Please connect Icaro"
	end 
  end
# set Icaro board to ready status
  def start(sp,value)
    begin
	@sp.write('s')
	@sp.write(value)
        return true
    rescue IOError => ex
        return ex
    end

  end
#Motor move robot DC motors 
# 1 forward
# 2 back
# 3 left
# 4 right
# 5 stop
# values are strings
  def motor(value)
   begin
	@sp.write('l')
	@sp.write(value)
        return @sp.read
    rescue IOError => ex
        return ex
    end

  end
#read analog input sensors
#there are 8 analog input ports
  def read_analog(value)
     begin
	@sp.write('e')
	@sp.write(value)
	return @sp.read
    rescue IOError => ex
        return ex
    end

  end
#read digital input sensor
#there are 4 digital input sensors ports
  def read_digital(value)
   begin
	@sp.write('d')
	@sp.write(value)
	return @sp.read==1 ? 1:0
    rescue IOError => ex
        return ex
    end

  end
#move servo motors
#Icaro board has 5 servo engines ports
#value is one of 255 characters and move the engine to that position
  def servo(servo,value)
    begin
	@sp.write('m')
	@sp.write(servo)
	@sp.write(value)
	return true
    rescue IOError => ex
	return ex
    end
  end
#sound produce a sound on the port
  def sound(audio,value)
    begin
	@sp.write('a')
	@sp.write(audio)
	@sp.write(value)
	sleep(0.01)
	@sp.write('s')
	@sp.write('0')
        return true
    rescue IOError => ex
        return ex
    end

  end
end

