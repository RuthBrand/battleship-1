require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < MiniTest::Test

  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_cells_is_a_instance_of_the_hash_class
    board = Board.new

    assert_instance_of Hash, board.cells
  end

  def test_cells_hash_has_16_key_value_pairs
    board = Board.new

    assert_equal 16, board.cells.size
  end

  def test_cells_hash_keys_point_to_cell_objects
    board = Board.new

    assert_instance_of Cell, board.cells.values[0]
  end

  def test_it_can_validate_coordinate
    board = Board.new

    assert board.valid_coordinate?("A1")
  end

  def test_it_can_validate_ship_placement_by_length_of_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    refute board.valid_size?(cruiser, ["A1", "A2"])
    assert board.valid_size?(cruiser, ["A1", "A2", "A3"])
  end

  def test_it_can_determine_if_horizontal_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert board.valid_horizontal_consecutive?(cruiser, ["A1", "A2", "A3"])
    refute board.valid_horizontal_consecutive?(cruiser, ["B1", "A2", "A3"])
    refute board.valid_horizontal_consecutive?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_horizontal_consecutive?(cruiser, ["A1", "A1", "A3"])
  end

  def test_it_can_determine_if_vertical_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    assert board.valid_vertical_consecutive?(cruiser, ["A1", "B1", "C1"])
    refute board.valid_vertical_consecutive?(cruiser, ["A1", "B1", "D1"])
    refute board.valid_vertical_consecutive?(cruiser, ["A1", "B2", "C1"])
    refute board.valid_vertical_consecutive?(cruiser, ["A1", "A1", "C1"])
  end

  def test_it_can_validate_ship_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert board.valid_placement?(cruiser, ["B1", "B2", "B3"])
    assert board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(submarine, ["A1", "B1"])
    refute board.valid_placement?(submarine, ["C2", "C4"])
    refute board.valid_placement?(submarine, ["C4", "C5"])
  end

  def test_it_will_not_validate_coordinate_not_on_board
    board = Board.new
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(submarine, ["C4", "C5"])
  end

  def test_it_can_place_ships_in_cells
    board = Board.new
    submarine = Ship.new("Submarine", 2)
    board.place(submarine, ["B2", "C2"])
    cell_1 = board.cells["B2"]
    cell_2 = board.cells["C2"]

    assert_equal submarine, cell_1.ship
    assert_equal submarine, cell_2.ship
    assert cell_1.ship == cell_2.ship
  end

  def test_that_ships_cannot_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(submarine, ["B2", "C2"])

    refute board.valid_placement?(cruiser, ["B1", "B2", "B3"])
  end

  def test_it_can_render_a_header
    board = Board.new

    assert_equal "  1 2 3 4 \n", board.render_header
  end

  def test_it_can_render_a_single_row
    board = Board.new

    assert_equal "A . . . . \n", board.render_row("A")
  end

  def test_it_can_render_a_board
    skip
    board = Board.new

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
  end
end
