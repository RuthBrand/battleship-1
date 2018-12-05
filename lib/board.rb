class Board
  attr_reader :cells

  def initialize
    @cells = {}
    create_board
  end

  def create_board
    range_numbers = "1".."4"
    range_letters = "A".."D"
    number_array = range_numbers.to_a
    letters_array = range_letters.to_a
    new_array = []

    letters_array.each do |letter|
      number_array.each do |number|
        new_array << letter + number
      end
    end

    new_array.each do |element|
      @cells[element] = Cell.new(element)
    end
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if valid_size?(ship, coordinates) == false
      return false
    elsif valid_horizontal_consecutive(ship, coordinates) == true || valid_vertical_consecutive(ship, coordinates) == true
      return true
    else
      return false
    end
  end

  def valid_size?(ship, coordinates)
    coordinates.count == ship.length
  end

  def valid_horizontal_consecutive?(ship, coordinates)
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      letters << coordinate[0]
      numbers << coordinate[1]
    end
    if letters.uniq.count != 1
      return false
    end
    range_test = numbers.first..numbers.last
    if range_test.count == ship.length
      return true
    else
      return false
    end
  end

  def valid_vertical_consecutive?(ship, coordinates)
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      letters << coordinate[0]
      numbers << coordinate[1]
    end
    if numbers.uniq.count != 1
      return false
    end
    range_test = letters.first..letters.last
    if range_test.count == ship.length
      return true
    else
      return false
    end
  end









end
