require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    ship = Ship.new("Cruiser", 3)
    assert_instance_of Ship, ship
  end

  def test_it_has_a_name
    ship = Ship.new("Cruiser", 3)
    assert_equal "Cruiser", ship.name
  end

  def test_it_has_a_length
    ship = Ship.new("Cruiser", 3)
    assert_equal 3, ship.length
  end

  def test_ship_has_a_health
    ship = Ship.new("Cruiser", 3)
    assert_equal 3, ship.health
  end













end
