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

    refute board.valid_placement?(cruiser, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["A1", "A2", "A3"])
  end


end
