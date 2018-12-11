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
end
