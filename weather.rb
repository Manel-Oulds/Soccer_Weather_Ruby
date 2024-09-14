def day_with_smallest_temperature_spread(file_path)
  table_started = false
  smallest_spread = Float::INFINITY
  day_with_smallest_spread = nil
  columns = {}

  File.foreach(file_path) do |line|
    # Detect the header row dynamically
    if line.match(/Dy\s+MxT\s+MnT/) || line.match(/^\d/)
      table_started = true
      headers = line.split(/\s+/).reject(&:empty?)

      columns[:day] = headers.index { |header| header.match(/^Dy/i) || header.match(/^\d+/) }
      columns[:max_temp] = headers.index { |header| header.match(/^MxT$/) }
      columns[:min_temp] = headers.index { |header| header.match(/^MnT$/) }

      # Check if columns are properly found
      unless columns.values.all?
        puts "Error: Unable to detect necessary columns."
        return
      end
      next
    end

    # Only parse the lines after the header
    next unless table_started
    next if line.strip.empty? || line.match(/^-+/) # Skip empty lines or separators

    # Handle different separators and parse columns
    columns_data = line.split(/\s+/).reject(&:empty?)

    # Ensure we have enough data to process
    next if columns_data.length <= [columns[:day], columns[:max_temp], columns[:min_temp]].max

    # Extract relevant columns
    day = columns_data[columns[:day]]
    max_temp_str = columns_data[columns[:max_temp]]
    min_temp_str = columns_data[columns[:min_temp]]

    # Convert temperatures to integers
    max_temp = max_temp_str.to_i
    min_temp = min_temp_str.to_i

    # Calculate temperature spread
    spread = max_temp - min_temp

    # Update the smallest spread and corresponding day
    if spread < smallest_spread
      smallest_spread = spread
      day_with_smallest_spread = day
    end
  end

  if day_with_smallest_spread
    puts "The day with the smallest temperature spread: " + day_with_smallest_spread
  else
    puts "No valid data found."
  end
end

# Test 
file_path = "w_data.dat"
day_with_smallest_temperature_spread(file_path)
