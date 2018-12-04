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

  def test_board_is_a_instance_of_the_hash_class
    board = Board.new

    assert_instance_of Hash, board
  end







end
