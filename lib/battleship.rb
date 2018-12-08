# require './lib/board'

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
      print ">"
      input = gets.chomp
      input = input.downcase
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
    puts "\n"

    computer_board = Board.new
    computer_cruiser = Ship.new("Cruiser", 3)
    computer_sub = Ship.new("Submarine", 2)

    random_array = computer_board.cells.keys.sample(3)
    while computer_board.valid_placement?(computer_cruiser, random_array) == false
      random_array = computer_board.cells.keys.sample(3)
    end
    computer_board.place(computer_cruiser, random_array)

    random_array = computer_board.cells.keys.sample(2)
    while computer_board.valid_placement?(computer_sub, random_array) == false
      random_array = computer_board.cells.keys.sample(2)
    end
    computer_board.place(computer_sub, random_array)

    user_board = Board.new
    user_cruiser = Ship.new("Cruiser", 3)
    user_sub = Ship.new("Submarine", 2)

    input = nil
    puts "I have laid out my ships on the grid.\nYou now need to lay out your ships.\nThe Cruiser is three units long and the Submarine is two units long."
    puts user_board.render
    puts "Enter the squares for the Cruiser (3 spaces):"
    print ">"
    input = gets.chomp
    input = input.upcase

    input_array = input.split
    while user_board.valid_placement?(user_cruiser, input_array) == false
      puts "Those are invalid coordinates. Please try again:"
      print ">"
      input = gets.chomp
      input = input.upcase
      input_array = input.split
    end
    user_board.place(user_cruiser, input_array)

    puts "\n"
    puts user_board.render(true)
    puts "Enter the squares for the Submarine (2 spaces):"
    print ">"

    input = gets.chomp
    input_array = input.split
    while user_board.valid_placement?(user_cruiser, input_array) == false
      puts "Those are invalid coordinates. Please try again:"
      print ">"
      input = gets.chomp
      input_array = input.split
    end
    user_board.place(user_sub, input_array)

    turn
  end

  def turn
    main_menu
  end
end
