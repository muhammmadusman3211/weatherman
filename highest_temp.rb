require 'date'

module Monthly

  def find_monthly_min_max_temprature(city, month, year)
    month  = month.to_i
    line_index = 0
    max_temp = []
    min_temp = []
    mean_temp = []
    mean_humidity = []
    day = 0

    if File.exist?(File.join(File.dirname(File.absolute_path(__FILE__)),"/#{city}_weather/#{city}_weather_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt"))
      file = File.open(File.join(File.dirname(File.absolute_path(__FILE__)),"/#{city}_weather/#{city}_weather_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt"))
      file.each_line.with_index do |line, index|
        if index > 1
          gst, max_temp, mean_temp[line_index], min_temp, min_dew, mean_dew, max_dev, min_humidity, mean_humidity[line_index], *data = line.split(',')
          if mean_temp[line_index] == ""
            print "FOUND"
            mean_temp.splice!(line_index, 1)
          end

          if mean_humidity[line_index] == ""
            max_humidity[line_index] = 0
          end

          if gst[0..3] == "<!--"
            mean_temp.slice!(line_index, 1)
            mean_humidity[line_index] = 0
          end

          line_index = line_index.next
        end
      end
    else
      print "File for this month does not exist."
      exit(0)
    end

    mean_temp.map!(&:to_i)
    mean_humidity.map!(&:to_i)


    puts "Maximum Mean Temperature:" + mean_temp.max.to_s + " on " + mean_temp.index(mean_temp.max).to_s + " " + Date::MONTHNAMES[month].to_s
    puts "Minimum Mean Temperature:" + mean_temp.min.to_s + " on " + mean_temp.index(mean_temp.min).to_s + " " + Date::MONTHNAMES[month].to_s
    puts "Mean Humidity:" + mean_humidity.max.to_s + " on " + mean_humidity.index(mean_humidity.min).to_s + " " + Date::MONTHNAMES[month].to_s

  end
end


#exception if the month does not exists
