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

  def test_it_prompts_main_menu
    battleship = Battleship.new

    assert_equal "Welcome to BATTLESHIP \nEnter p to play. Enter q to quit.", battleship.main_menu
  end

end
