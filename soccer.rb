def team_with_smallest_goal_difference(file_path)
  table_started = false
  smallest_difference = Float::INFINITY
  team_with_smallest_difference = nil
  columns = {}

  File.foreach(file_path) do |line|
    # Detect the header row
    if line.match(/Team.*P.*W.*L.*D.*F.*A/)
      table_started = true
      headers = line.split(/[^a-zA-Z0-9]+/)

      columns[:team] = headers.index { |header| header.match(/^Team/i) }
      columns[:goals_for] = headers.index { |header| header.match(/^F$/) }
      columns[:goals_against] = headers.index { |header| header.match(/^A$/) }

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

    # Handle different separators
    columns_data = line.split(/\s+|\s*-\s*/).reject(&:empty?)

    # Ensure we have enough data to process
    next if columns_data.length <= [columns[:goals_against], columns[:goals_for]].max

    # Extract relevant columns
    goals_for_str = columns_data[columns[:goals_for]]
    goals_against_str = columns_data[columns[:goals_against]]

    # Remove any non-numeric characters from the extracted data
    goals_for = goals_for_str.gsub(/\D/, '').to_i
    goals_against = goals_against_str.gsub(/\D/, '').to_i

    difference = (goals_for - goals_against).abs

    # Extract the team name
    # Remove any leading numeric values and spaces, then join remaining parts
    team_name_parts = line.split(/\s+|\s*-\s*/).reject(&:empty?)
    team_name_parts.reject! { |part| part.match(/^\d+$/) } 

    # Extract the team name by joining the parts that are not empty
    team_name = team_name_parts[0...columns[:goals_for]].join(' ').strip
    team_name = team_name.match(/[a-zA-Z].*/)

    # Update the smallest difference and corresponding team
    if difference < smallest_difference
      smallest_difference = difference
      team_with_smallest_difference = team_name
    end
  end

  if team_with_smallest_difference
    puts  team_with_smallest_difference
  else
    puts "No valid data found."
  end
end

# File path to your soccer data file
file_path = "soccer.dat"

# Call the function
team_with_smallest_goal_difference(file_path)
