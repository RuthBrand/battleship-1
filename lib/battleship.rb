# require './lib/board'

class Battleship
  attr_reader :computer_board,
              :computer_cruiser,
              :computer_sub,
              :user_board,
              :user_cruiser,
              :user_sub



  def initialize
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_sub = Ship.new("Submarine", 2)
    @user_board = Board.new
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_sub = Ship.new("Submarine", 2)
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
      input = gets.chomp
      input = input.upcase
      input_array = input.split
      # require 'pry'; binding.pry
    end
    user_board.place(user_cruiser, input_array)
    puts user_board.render(true)

    puts "Enter the squares for the Submarine (2 spaces):"
    print ">"
    input = gets.upcase.chomp
    input_array = input.split
    while user_board.valid_placement?(user_sub, input_array) == false

      puts "Those are invalid coordinates. Please try again:"
      input = gets.upcase.chomp

      input_array = input.split

    end
    user_board.place(user_sub, input_array)

    puts "\n"
    puts user_board.render(true)
    turn
  end

  def turn
    puts "=============COMPUTER BOARD============="
    puts computer_board.render

    puts "=============STUDENT BOARD============="
    puts user_board.render(true)

    puts "Enter the coordinate for your shot:"
    print '>'

    user_shot = gets.upcase.chomp
    while computer_board.valid_coordinate?(user_shot) == false || computer_board.cells[user_shot].fired_upon? == true
      puts "Please enter a valid coordinate:"
      puts ">"
      user_shot = gets.upcase.chomp
    end
    computer_board.cells[user_shot].fire_upon
    computer_shot = user_board.cells.keys.sample
    while user_board.valid_coordinate?(computer_shot) == false || user_board.cells[computer_shot].fired_upon? == true

      computer_shot = user_board.cells.keys.sample
    end
    user_board.cells[computer_shot].fire_upon
    # puts user_board.render(true)
    end_game
  end






  def game


  end

  def end_game


    main_menu
  end























end
