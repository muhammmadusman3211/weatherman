#inlcude inside classs

require 'date'
require_relative 'highest_temp'
require_relative 'yearly_temp'
require_relative 'colored_monthly_temp'


class Weatherman
  include Monthly
  include Yearly

  def initialize(task_identifier, date, path_to_file)
    @task_identifier = task_identifier
    @date  = date
    @path_to_file = path_to_file
    @year = 0
    @month = 0
    @city = ""
    puts @task_identifier, @date, @path_to_file
  end

  def populate_parameters
    if @task_identifier == "-e"
      @year = @date
    elsif @task_identifier == "-a" || "-c"
      @year, @month = @date.split('/')
    else
      print "Your input is not valid"
    end
  end

  def getFirstParam
    return @task_identifier
  end

  def print_monthly_min_max_temperature
    max = find_monthly_min_max_temprature(@year, @month, @path_to_file)
    puts max
  end

  def print_colored_monthly_temperature
    colored_monthly_temperature(@year, @month, @path_to_file)
  end


  def print_yearly_min_max_temperature
    find_yearly_min_max_temperature(@year, @path_to_file)
  end
end

weatherman = Weatherman.new(ARGV[0], ARGV[1], ARGV[2])
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
