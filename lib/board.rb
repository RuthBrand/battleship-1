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
    coordinates.count == ship.length
  end




end
