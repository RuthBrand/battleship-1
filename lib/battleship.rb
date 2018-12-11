class Battleship
  attr_reader :computer_board,
              :computer_ship_1,
              :computer_ship_2,
              :user_board,
              :user_ship_1,
              :user_ship_2

  def initialize
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
    create_custom_board
    custom_user_ships
    place_computer_ships
    place_user_ships
    game
  end

  def create_custom_board
    puts "Please choose the size of your board (Minimum 4, Maximum 26):"
    print ">"
    user_board_size = gets.chomp.to_i
    until user_board_size >= 4 && user_board_size <= 26
      puts "Invalid board size. Please pick again:"
      user_board_size = gets.chomp.to_i
    end
    row_letter = (user_board_size + 64).chr
    @user_board = Board.new(user_board_size, row_letter)
    @computer_board = Board.new(user_board_size, row_letter)
  end

  def custom_user_ships
    puts "Please name your first ship:"
    print ">"
    custom_ship_name_1 = gets.chomp
    puts "Please choose a length for your #{custom_ship_name_1}:"
    print ">"
    custom_ship_length_1 = gets.chomp.to_i

    @computer_ship_1 = Ship.new(custom_ship_name_1, custom_ship_length_1)
    @user_ship_1 = Ship.new(custom_ship_name_1, custom_ship_length_1)

    puts "Please name your second ship:"
    print ">"
    custom_ship_name_2 = gets.chomp
    puts "Please choose a length for your #{custom_ship_name_2}:"
    print ">"
    custom_ship_length_2 = gets.chomp.to_i

    @computer_ship_2 = Ship.new(custom_ship_name_2, custom_ship_length_2)
    @user_ship_2 = Ship.new(custom_ship_name_2, custom_ship_length_2)
  end

  def place_computer_ships
    coordinate_array = []
    while computer_board.valid_placement?(computer_ship_1, coordinate_array) == false
      random_coordinate = computer_board.cells.keys.sample
      randomizer = [1, 2]
      if randomizer.sample == 1
        coordinate_index = computer_board.cells.keys.index(random_coordinate)
        coordinate_range = coordinate_index..(coordinate_index + (computer_ship_1.length - 1))
        coordinate_array = coordinate_range.map do |index|
          computer_board.cells.keys[index]
        end
      else
        computer_board.cells.keys.each do |coordinate|
          if coordinate.include?(random_coordinate[1])
            coordinate_array << coordinate
          end
          if coordinate_array.count == computer_ship_1.length
            break
          end
        end
      end
    end
    computer_board.place(computer_ship_1, coordinate_array)

    coordinate_array = []
    while computer_board.valid_placement?(computer_ship_2, coordinate_array) == false
      random_coordinate = computer_board.cells.keys.sample
      randomizer = [1, 2]
      if randomizer.sample == 2
        coordinate_index = computer_board.cells.keys.index(random_coordinate)
        coordinate_range = coordinate_index..(coordinate_index + (computer_ship_2.length - 1))
        coordinate_array = coordinate_range.map do |index|
          computer_board.cells.keys[index]
        end
      else
        computer_board.cells.keys.each do |coordinate|
          if coordinate.include?(random_coordinate[1])
            coordinate_array << coordinate
          end
          if coordinate_array.count == computer_ship_2.length
            break
          end
        end
      end
    end
    computer_board.place(computer_ship_2, coordinate_array)
    puts computer_board.render(true)
  end

  def place_user_ships
    input = nil
    puts "I have laid out my ships on the grid.\nYou now need to lay out your ships.\nThe #{user_ship_1.name} is #{user_ship_1.length} units long and the #{user_ship_2.name} is #{user_ship_2.length} units long."
    puts user_board.render
    puts "Enter the squares for the #{user_ship_1.name} (#{user_ship_1.length} spaces):"
    print ">"
    input = gets.chomp
    input = input.upcase

    input_array = input.split
    while user_board.valid_placement?(user_ship_1, input_array) == false
      puts "Those are invalid coordinates. Please try again:"
      print ">"
      input = gets.chomp
      input = input.upcase
      input_array = input.split
    end

    user_board.place(user_ship_1, input_array)
    puts user_board.render(true)
    puts "Enter the squares for the #{user_ship_2.name} (#{user_ship_2.length} spaces):"
    print ">"
    input = gets.upcase.chomp
    input_array = input.split

    while user_board.valid_placement?(user_ship_2, input_array) == false
      puts "Those are invalid coordinates. Please try again:"
      input = gets.upcase.chomp
      input_array = input.split
    end

    user_board.place(user_ship_2, input_array)
    puts "\n"
    puts user_board.render(true)
  end

  def turn
    puts "\n"
    puts "=============COMPUTER BOARD============="
    puts computer_board.render

    puts "\n"
    puts "=============STUDENT BOARD============="
    puts user_board.render(true)

    puts "Enter the coordinate for your shot:"
    print '>'

    user_shot = gets.upcase.chomp
    while computer_board.valid_coordinate?(user_shot) == false || computer_board.cells[user_shot].fired_upon? == true
      puts "Please enter a valid coordinate:"
      print ">"
      user_shot = gets.upcase.chomp
    end

    computer_board.cells[user_shot].fire_upon
    computer_shot = user_board.cells.keys.sample

    while user_board.valid_coordinate?(computer_shot) == false || user_board.cells[computer_shot].fired_upon? == true
      computer_shot = user_board.cells.keys.sample
    end

    user_board.cells[computer_shot].fire_upon
    puts "Your shot on #{user_shot} was a #{computer_board.cells[user_shot].status_feedback}"
    puts "My shot on #{computer_shot} was a #{user_board.cells[computer_shot].status_feedback}"
  end

  def game
    until (computer_ship_1.sunk? == true && computer_ship_2.sunk? == true) || (user_ship_1.sunk? == true && user_ship_2.sunk? == true)
      turn
    end
    end_game
  end

  def end_game
    puts "=============COMPUTER BOARD============="
    puts computer_board.render

    puts "=============STUDENT BOARD============="
    puts user_board.render(true)

    if computer_ship_1.sunk? == true && computer_ship_2.sunk? == true
      puts "You Won!!!"
    else
      puts "I Won... You'll never beat me..."
    end
    puts "Would you like to play again?"
  end
end
