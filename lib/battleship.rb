class Battleship


  def initialize
    start
  end

  def start
    main_menu

  end

  def main_menu
    input = nil
    while input != "q"
      puts "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit."
      input = gets.chomp
      if input == "p"
        setup
      elsif input == "q"
        puts "Thanks for playing BATTLESHIP"
      else
        puts "Invalid Input"
      end
    end
  end

  def setup
    board = Board.new
    computer_cruiser = Ship.new("Cruiser", 3)
    computer_sub = Ship.new("Submarine", 2)
    #here goes the code for random but valid computer ship placement
    user_cruiser = Ship.new("Cruiser", 3)
    user_sub = Ship.new("Submarine", 2)

    input = nil
    puts "I have laid out my ships on the grid.\nYou now need to lay out your ships.\nThe Cruiser is three units long and the Submarine is two units long."
    puts board.render
    puts "Enter the squares for the Cruiser (3 spaces):"
    # print = ">"
    input = gets.chomp
    input_array = input.split
    while board.valid_placement?(user_cruiser, input_array) == false

      puts "Please enter a valid placement."
      input = gets.chomp
      input_array = input.split
      # require 'pry'; binding.pry
    end
    board.place(user_cruiser, input_array)
    puts board.render(true)

  end














end
