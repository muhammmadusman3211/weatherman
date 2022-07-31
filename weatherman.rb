require 'date'
class Weatherman
  require_relative 'highest_temp'
  require_relative 'yearly_temp'
  require_relative 'colored_monthly_temp'
  include Monthly
  include Yearly

  def initialize(task_identifier, date, path_to_file, extra)
    @task_identifier = task_identifier
    @date  = date
    @path_to_file = path_to_file
    @year = 0
    @month = 0
    @city = ""
    @extra = extra
  end

  def populate_parameters
    if @task_identifier == "-e"
      @year = @date
    elsif @task_identifier == "-a" || "-c"
      @year, @month  = @date.split('/')
    else
      print "Your input is not valid"
      exit
    end

    if @extra
      print "Your input is not valid"
      exit
    end

  end

  def getFirstParam
    return @task_identifier
  end

  def print_monthly_min_max_temperature
    find_monthly_min_max_temprature(@year, @month, @path_to_file)

  end

  def print_colored_monthly_temperature
    colored_monthly_temperature(@year, @month, @path_to_file)
  end


  def print_yearly_min_max_temperature
    find_yearly_min_max_temperature(@year, @path_to_file)
  end
end

weatherman = Weatherman.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
weatherman.populate_parameters

if weatherman.getFirstParam == "-a"

  monthly_report = weatherman.print_monthly_min_max_temperature
  puts "Average Maximum Temperature:" + (monthly_report[0].sum/monthly_report[0].length).to_s
  puts "Average Minimum Temperature:" + monthly_report[1].min.to_s
  puts "Average Humidity:" + monthly_report[2].max.to_s

elsif weatherman.getFirstParam == "-c"

  weatherman.print_colored_monthly_temperature

elsif weatherman.getFirstParam == "-e"

  yearly_report = weatherman.print_yearly_min_max_temperature
  print "Maximum Temparature ", yearly_report[0], "C on", " ", yearly_report[1], " ", Date::MONTHNAMES[yearly_report[2]].to_s
  puts ""
  print "Minimum Temparature ", yearly_report[3], "C on", " ", yearly_report[4], " ", Date::MONTHNAMES[yearly_report[5]].to_s
  puts ""
  print "Maximum Humidity ", yearly_report[6].max.to_s, "% on", " ", yearly_report[7], " ", Date::MONTHNAMES[yearly_report[8]].to_s
  puts ""

else

  print "You have given an invalid input"

end

