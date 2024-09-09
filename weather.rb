# Strategie to find the day with the smallest temperature spread
    # Open the temperature spread file
    # Skip the headers and non-weather information lines using regex that check digits (means it's a valid line)
    # Loop through the temperature spread file
        # Split the line to get the day, min_temperature, and max_temperature
        # Calculate the temperature spread for each day
        # Update the value of the smallest temperature spread if smaller than the old value
        # return the day with the smallest temperature spread

def find_day_with_smallest_spread(file_path)
    smallest_spread = Float::INFINITY
    day_with_smallest_spread = nil
  
    File.foreach(file_path) do |line|
      # Skip lines that don't contain valid data using regex
      next unless line.match(/^\s*\d+/)
  
      # Split the line to extract each data
      columns = line.split
  
      day = columns[0].to_i       #Day of the month
      max_temp = columns[1].to_f  #Max temperature
      min_temp = columns[2].to_f  #Min temperature
  
      # Calculate the spread
      spread = max_temp - min_temp
  
      # Update the smallest spread and corresponding day if a smaller one is found
      if spread < smallest_spread
        smallest_spread = spread
        day_with_smallest_spread = day
      end
    end
  
    # Return the result
    puts "Day with the smallest temperature spread: #{day_with_smallest_spread}"
  end
  
  #Test: Day 14 has the smallest spread
  file_path = "w_data.dat"
  find_day_with_smallest_spread(file_path)
  