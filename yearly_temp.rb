
module Yearly
  def find_yearly_min_max_temperature(city,year)

    month = 1
    max_at_day = 1
    min_at_day = 1
    maximum_temp = 0
    minimum_temp = 100
    maximum_humidity = 0
    max_temp = []
    min_temp = []
    max_humidity = []
    max_at_month = 1
    min_at_month = 1
    max_humid_at_day = 1
    max_humid_at_month = 1
    error = 0

    12.times do
      line_index = 0
    if File.exist? (File.join(File.dirname(File.absolute_path(__FILE__)),"/#{city}_weather/#{city}_weather_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt"))
      file = File.open(File.join(File.dirname(File.absolute_path(__FILE__)),"/#{city}_weather/#{city}_weather_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt"))
      file.each_line.with_index{ |line, index|
        if index > 1
          gst, max_temp[line_index], mean, min_temp[line_index], min_dew, mean_dew, max_dew, max_humidity[line_index], *data = line.split(',')
          if max_temp[line_index] == ""
            max_temp[line_index] = 0
          end

          if min_temp[line_index] == ""
            min_temp[line_index] = 99
          end

          if max_humidity[line_index] == ""
            max_humidity[line_index] = 0
          end

          if gst[0..3] == "<!--"
            max_temp[line_index] = 0
            min_temp[line_index] = 100
            max_humidity[line_index] = 0
          end
          line_index = line_index.next
        end
      }
      file.close
    else
      puts "File for" + Date::MONTHNAMES[month].to_s[0..2] + "do not exist"
      error = error.next
    end

    max_temp.map!(&:to_i)
    min_temp.map!(&:to_i)
    max_humidity.map!(&:to_i)

    if max_temp.max.to_i > maximum_temp
      maximum_temp = max_temp.max
      max_at_month = month
      max_at_day = max_temp.index(max_temp.max) + 1
    end

    if max_humidity.max.to_i > maximum_humidity
      maximum_humidity = max_humidity.max
      max_humid_at_month = month
      max_humid_at_day = max_humidity.index(max_humidity.max) + 1
    end

    if min_temp.min.to_i < minimum_temp
      minimum_temp = min_temp.min.to_i
      min_at_month = month
      min_at_day = min_temp.index(min_temp.min).to_i + 1
    end

    month = month.next


  end
  if error != 12
    print "Maximum Temparature ", maximum_temp, "C on", " ", max_at_day, " ", Date::MONTHNAMES[max_at_month].to_s
    puts ""
    print "Minimum Temparature ", minimum_temp, "C on", " ", min_at_day, " ", Date::MONTHNAMES[min_at_month].to_s
    puts ""
    print "Maximum Humidity ", max_humidity.max.to_s, "% on", " ", max_humid_at_day, " ", Date::MONTHNAMES[max_humid_at_month].to_s
    puts ""
  end
  end
end

#exception if the year does not exists
#exception
