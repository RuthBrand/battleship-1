require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/battleship'


class BattleshipTest < MiniTest::Test

  def test_it_exists
    battleship = Battleship.new

    assert_instance_of Battleship, battleship
  end

  # def test_random_horizontal_placement
  #   battleship = Battleship.new
  #
  #
  # end
  #
  # def test_random_vertical_placement
  #
  # end







end
