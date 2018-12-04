require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    ship = Ship.new("Cruiser")
    assert_instance_of Ship, ship
  end

  def test_it_has_a_name
    ship = Ship.new("Cruiser")
    assert_equal "Cruiser", ship.name
  end








end
