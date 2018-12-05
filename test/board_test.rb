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








end
