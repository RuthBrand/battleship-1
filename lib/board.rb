class Board
  attr_reader :cells

  def initialize
    @cells = {}
    create_board(4, "D")
  end

  def create_board(last_number, last_letter)
    ("A"..last_letter).each do |letter|
      ("1"..last_number.to_s).each do |number|
        @cells[letter + number] = Cell.new(letter + number)
      end
    end
  end

  def valid_placement?(ship, coordinates)
    coordinates.each do |coordinate|
      if valid_coordinate?(coordinate) == false
        return false
      end
    end
    if cell_unoccupied?(coordinates) == false
      return false
    elsif valid_size?(ship, coordinates) == false
      return false
    elsif valid_horizontal_consecutive?(ship, coordinates) == true || valid_vertical_consecutive?(ship, coordinates) == true
      return true
    else
      return false
    end
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
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
    if range_test.to_a != numbers
      return false
    elsif range_test.count == ship.length
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
    if range_test.to_a != letters
      return false
    elsif range_test.count == ship.length
      return true
    else
      return false
    end
  end

  def cell_unoccupied?(coordinates)
    coordinates.each do |coordinate|
      if @cells[coordinate].empty? == false
        return false
      end
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) == false
      return "Invalid Ship Placement"
    else
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def render(see_ship = false)
    render_string = cells.keys.map {|cell| cell[0]}
    rendered_rows = render_string.uniq.map do |letter|
      render_row(letter)
    end
    render_header + rendered_rows.join
  end

  def render_row(row)
    correct_cells = cells.keys.find_all do |key|
      key[0] == row
    end
    statuses = correct_cells.map do |key|
      cells[key].render
    end
    row + " " + statuses.join(" ") + (" \n")
  end

  def render_header
    number_range = cells.keys.map {|cell| cell[1]}
    number_header = number_range.uniq.join" "
    "  " + number_header + " \n"
  end
end
