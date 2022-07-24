require 'colorize'

def colored_monthly_temperature(city, month, year)
  month = month.to_i
  line_index = 0
  max_temp = []
  min_temp = []
  if File.exist? (File.join(File.dirname(File.absolute_path(__FILE__)),"/#{city}_weather/#{city}_weather_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt"))
  file = File.open(File.join(File.dirname(File.absolute_path(__FILE__)),"/#{city}_weather/#{city}_weather_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt"))
    file.each_line.with_index do |line, index|
      if index > 1
        gst, max_temp[line_index], mean, min_temp[line_index], *data = line.split(',')

        min_temp[line_index].to_i.times do
          print "+".blue
        end

        max_temp[line_index].to_i.times do
          print "+".red
        end
        print min_temp[line_index].to_s + "C" + "-"
        puts max_temp[line_index].to_s + "C"
        line_index = line_index.next
      end

    end
  else
    puts "File for this month does not exist"
  end
end


#exception if the month does not exist
