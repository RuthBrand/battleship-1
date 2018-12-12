class Battleship
  attr_reader :computer_board,
              :user_board,
              :board_width,
              :board_length,
              :user_ships,
              :computer_ships

  def initialize
    @user_ships = []
    @computer_ships = []
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
    puts "Would you like to create your own ships? Or use the default ships (Cruiser, Submarine)?"
    puts "Please enter c to create custom ships; enter d to use the default ships."
    print ">"
    user_input = gets.upcase.chomp
    while user_input != "C" && user_input != "D"
      puts "Please enter either c or d."
      print ">"
      user_input = gets.upcase.chomp
    end
    if user_input == "C"
      custom_user_ships
    else
      default_ships
    end
    place_computer_ships
    place_user_ships
    game
  end

  def default_ships
    user_cruiser = Ship.new("Cruiser", 3)
    user_sub = Ship.new("Submarine", 2)
    computer_cruiser = Ship.new("Cruiser", 3)
    computer_sub = Ship.new("Submarine", 2)
    @user_ships = [user_cruiser, user_sub]
    @computer_ships = [computer_cruiser, computer_sub]
  end


  def create_custom_board
    puts "Please choose the size of your board (max width/length is 26, min is 4):"
    puts "Enter in the width of the board."
    print ">"
    local_board_width = gets.chomp.to_i
    while local_board_width < 4 || local_board_width > 26
      puts "Invalid board width. Please pick a number between 4 and 26:"
      local_board_width = gets.chomp.to_i
    end
    @board_width = local_board_width

    puts "Enter in the length of the board."
    print ">"
    local_board_length = gets.chomp.to_i
    while local_board_length < 4 || local_board_length > 26
      puts "Invalid board length. Please pick a number between 4 and 26:"
      local_board_length = gets.chomp.to_i
    end
    @board_length = local_board_length

    row_letter = (@board_length + 64).chr
    @user_board = Board.new(@board_width, row_letter)
    @computer_board = Board.new(@board_width, row_letter)
  end

  def custom_user_ships
    user_input = "Y"
    ship_max = 0
    if board_length > board_width
      ship_max = board_width
    else
      ship_max = board_length
    end
    while user_input == "Y" && user_ships.count < ship_max
      puts "You can make #{ship_max} ships"
      puts "You have made #{user_ships.count} ships."
      puts "Please name your ship:"
      print ">"
      custom_ship_name = gets.chomp
      puts "Please choose a length for your #{custom_ship_name}:"
      print ">"
      custom_ship_length = gets.chomp.to_i
      while custom_ship_length == 0 || (custom_ship_length > @board_width && custom_ship_length > @board_length)
        puts "Please enter a valid ship length"
        print ">"
        custom_ship_length = gets.chomp.to_i
      end
      @computer_ships << Ship.new(custom_ship_name, custom_ship_length)
      @user_ships << Ship.new(custom_ship_name, custom_ship_length)
      if ship_max == user_ships.count
        puts "You have reached the maximum number of ships."
      end
        break if ship_max == user_ships.count
      puts "Would you like to create another ship? (Y or N)"
      print ">"
      user_input = gets.upcase.chomp

      while user_input != "N" && user_input != "Y"
        puts "Please type 'Y' or 'N'"
        print ">"
        user_input = gets.upcase.chomp
      end
    end
  end

  def place_computer_ships
    @computer_ships.each do |computer_ship|
      coordinate_array = []
      while computer_board.valid_placement?(computer_ship, coordinate_array) == false
        random_coordinate = computer_board.cells.keys.sample
        randomizer = ["horizontal", "vertical"]
        randomizer_selection = randomizer.sample
        if randomizer_selection == "horizontal"
          coordinate_index = computer_board.cells.keys.index(random_coordinate)
          coordinate_range = coordinate_index..(coordinate_index + (computer_ship.length - 1))
          coordinate_array = coordinate_range.map do |index|
            computer_board.cells.keys[index]
          end
          break
        else
          computer_board.cells.keys.each do |coordinate|
            if coordinate.include?(random_coordinate[1])
              coordinate_array << coordinate
            end
            if coordinate_array.count == computer_ship.length
              break
            end
          end
        end
      end
      computer_board.place(computer_ship, coordinate_array)
    end
  end

  def place_user_ships
    puts "I have laid out my ships on the grid.\nYou now need to lay out your ships."
    @user_ships.each do |user_ship|
      user_ship_coordinates = nil
      puts "#{user_ship.name} is #{user_ship.length} units long."
      puts user_board.render(true)
      puts "Enter the squares for the #{user_ship.name} (#{user_ship.length} spaces):"
      print ">"
      user_ship_coordinates = gets.upcase.chomp
      coordinate_array = user_ship_coordinates.split

      while user_board.valid_placement?(user_ship, coordinate_array) == false
        puts "Those are invalid coordinates. Please try again:"
        print ">"
        user_ship_coordinates = gets.upcase.chomp
        coordinate_array = user_ship_coordinates.split
      end

      user_board.place(user_ship, coordinate_array)
      puts user_board.render(true)
    end
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
      if computer_board.cells[user_shot].fired_upon? == true
        puts "This coordinate has already been fired upon."
      end
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
    computer_sunk_ships = []
    user_sunk_ships = []

    until computer_sunk_ships.count == @computer_ships.count || user_sunk_ships.count == @user_ships.count
      turn
      computer_sunk_ships = []
      user_sunk_ships = []
      @computer_ships.each do |ship|
        computer_sunk_ships << ship if ship.sunk?
      end
      @user_ships.each do |ship|
        user_sunk_ships << ship if ship.sunk?
      end

    end
    end_game
  end

  def end_game
    computer_ships_remaining = []

    puts "=============COMPUTER BOARD============="
    puts computer_board.render

    puts "=============STUDENT BOARD============="
    puts user_board.render(true)

    @computer_ships.each do |ship|
      computer_ships_remaining << ship if ship.sunk? != true
    end
    if computer_ships_remaining == []
      puts "You Won!!!"
    else
      puts "I Won... You'll never beat me..."
    end
    puts "Would you like to play again?"
  end
end
