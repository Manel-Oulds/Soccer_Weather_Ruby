# Strategie to find the dteam_with_smallest_goal_difference
    # Open the soccer file
    # Skip the headers and non-soccer information lines using regex that check digits (means it's a valid line)
    # Loop through the soccer file
        # Split the line to get the team, goals for and goals against
        # Calculate the difference between the goals for and the goals against
        # Update the smallest_goal_difference if the actual smallest_diffrence is smaller than the smallest_goal_difference
        # return the team name with the smallest difference


def team_with_smallest_goal_difference(file_path)
    smallest_difference = Float::INFINITY
    team_with_smallest_difference = nil
  
    File.foreach(file_path) do |line|
      # Skip lines that don't contain valid data using regex
      next unless line.match(/^\s*\d+\./)
  
      # Split the line into columns and extract relevant data
      columns = line.split
  
      team_name = columns[1]           # Team name
      goals_for = columns[6].to_i      # 'F' (goals for)
      goals_against = columns[8].to_i  # 'A' (goals against)
  
      # Calculate the goal difference
      difference = (goals_for - goals_against).abs
  
      # Update the smallest difference and corresponding team if a smaller one is found
      if difference < smallest_difference
        smallest_difference = difference
        team_with_smallest_difference = team_name
      end
    end
  
    # Return the result
    puts "Team with the smallest goal difference: #{team_with_smallest_difference}"
  end
  
  #Test: Team with the smallest goal difference is  Aston_Villa
  file_path = "soccer.dat"
  team_with_smallest_goal_difference(file_path)
  