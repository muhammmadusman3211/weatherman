require 'date'

module Monthly

  def find_monthly_min_max_temprature(year, month, path_to_file)
    month  = month.to_i
    line_index = 0
    max_temp = []
    min_temp = []
    mean_humidity = []
    day = 0

    if File.exist?(File.join(File.dirname(File.absolute_path(__FILE__)), path_to_file + "/" + path_to_file + "_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt" ))
      file = File.open(File.join(File.dirname(File.absolute_path(__FILE__)), path_to_file + "/" + path_to_file + "_#{year}_#{Date::MONTHNAMES[month].to_s[0..2]}.txt"))
      file.each_line.with_index do |line, index|
        if index > 1
          gst, max_temp[line_index], mean_temp, min_temp[line_index], min_dew, mean_dew, max_dev, min_humidity, mean_humidity[line_index], *data = line.split(',')
          if max_temp[line_index] == ""
            max_temp.splice!(line_index, 1)
          end

          if min_temp[line_index] == ""
            min_temp.splice!(line_index, 1)
          end

          if mean_humidity[line_index] == ""
            max_humidity[line_index] = 0
          end

          if gst[0..3] == "<!--"
            max_temp.slice!(line_index, 1)
            min_temp.slice!(line_index, 1)
            mean_humidity.slice(line_index, 1)
          end

          line_index = line_index.next
        end
      end
    else
      print "File for this month does not exist."
      exit(0)
    end

    max_temp.map!(&:to_i)
    min_temp.map!(&:to_i)
    mean_humidity.map!(&:to_i)

    return [max_temp, min_temp, mean_humidity]


  end
end


#exception if the month does not exists
