
Module Yearly
def find_yearly_min_max_temperature(city,year)
  line_index = 0
  month = 1
  maximum_temp = 0
  max_temp = []
  min_temp = []

  12.times do
  if File.exist? ("/home/dev/Documents/ruby_project/#{city}_weather/#{city}_weather_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt")
    file = File.open("/home/dev/Documents/ruby_project/#{city}_weather/#{city}_weather_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt")
    file.each_line.with_index
    { |line, index|
      if index > 1
        gst, max_temp[line_index], mean, min_temp[line_index], *data = line.split(',')
        line_index = line_index.next
      end
    }
    file.close
  end
  month = month.next
  max_temp.map!(&:to_i)
  if  max_temp.max > maximum_temp
    maximum_temp = max_temp.max
  end
  puts "max", maximum_temp

end
end
