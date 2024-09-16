basic_colors = ["red", "green", "blue", "yellow", "black", "white", "orange", "purple"]

$computer_generated = true

# Method to get and validate user input
def get_valid_colors(basic_colors)
  loop do
    if $computer_generated
      # Get user input
      puts ""
      puts "Enter multiple colors separated by spaces (e.g., red blue green):"
    else
      puts ""
      puts "Second player"
      puts "Enter multiple colors separated by spaces (e.g., red blue green):"
    end
    user_input = gets.chomp.downcase

    # Split the input string into an array
    user_colors = user_input.split(" ")

    # Check if each user input color is in the basic_colors array
    invalid_colors = user_colors.reject { |color| basic_colors.include?(color) }

    # If there are invalid colors, prompt the user to retype
    if invalid_colors.empty?
      return user_colors # All colors are valid, exit the loop
    else
      puts "Invalid colors: #{invalid_colors.join(', ')}. Please re-enter valid colors."
    end
  end
end

puts "Do you want to input the colors for the random array or generate randomly? (type 'input' or 'random'):"
user_choice = gets.chomp.downcase

random_colors = []

if user_choice == 'input'
  $computer_generated = false
  # Get user input for the random colors
  puts "Please enter 4 colors for the random color array:"
  random_colors = get_valid_colors(basic_colors)
else
  # Generate 4 random colors, allowing duplicates
  random_colors = Array.new(4) { basic_colors.sample }
end

loop do
  valid_colors = get_valid_colors(basic_colors)

  # Display the array
  puts "You entered the following colors: #{valid_colors.join(', ')}"

  # Initialize output array
  output_symbols = []
  fully_guessed = true  # To track if all guesses are correct

  # Compare colors and positions
  valid_colors.each_with_index do |color, index|
    match_symbol = "" # Initialize symbol for each color
    color_occurrences_in_random = random_colors.count(color)

    if random_colors[index] == color
      output_symbols << "!"  # If the color is in the same position, add '!' (once or more based on position)
    elsif random_colors.include?(color)
      output_symbols << "*" # If the color exists elsewhere in the random array, add '*' based on occurrence
      fully_guessed = false
    else
      output_symbols << " "  # If not in the same position, add a space
      fully_guessed = false  # If any color is not in the correct position, flag as false
    end
  end

  # Display results
  valid_colors.each_with_index do |color, index|
    puts "#{color.capitalize}: #{output_symbols[index]}"
  end

  # Check if the user guessed all positions correctly
  if fully_guessed
    puts "Congratulations! You've guessed all the colors and their positions correctly."
    break
  else
    puts "Keep trying! Not all positions are correct yet."
  end
end
