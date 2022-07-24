#inlcude inside classs

require 'date'
require_relative 'highest_temp'
require_relative 'yearly_temp'
require_relative 'colored_monthly_temp'


class Weatherman
  include Monthly
  include Yearly

  def initialize(first_param, second_param)
    @first_param = first_param
    @second_param  = second_param
    @year = 0
    @month = 0
    @city = ""
  end

  def populate_parameters
    if @first_param == "-e"
      @year, @city = @second_param.split('/')
    elsif @first_param == "-a" || "-c"
      @year, @month, @city = @second_param.split('/')
    else
      print "Your input is not valid"
    end
  end

  def getFirstParam
    return @first_param
  end

  def print_monthly_min_max_temperature
    max = find_monthly_min_max_temprature(@city, @month, @year)
    puts max
  end

  def print_colored_monthly_temperature
    colored_monthly_temperature(@city, @month, @year)
  end


  def print_yearly_min_max_temperature
    find_yearly_min_max_temperature(@city, @year)
  end
end

weatherman = Weatherman.new(ARGV[0], ARGV[1])
weatherman.populate_parameters

if weatherman.getFirstParam == "-a"
  weatherman.print_monthly_min_max_temperature
elsif weatherman.getFirstParam == "-c"
  weatherman.print_colored_monthly_temperature
elsif weatherman.getFirstParam == "-e"
  weatherman.print_yearly_min_max_temperature
else
  print "You have given an invalid input"
end
#exception if the city, month or year does not exist
