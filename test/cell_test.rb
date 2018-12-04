require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_a_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_if_have_ship
    cell = Cell.new("B4")

    # ruby is recommending assert_nil
    assert_equal nil, cell.ship
  end

  def test_if_empty?
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_place_ship_method
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser")
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
  end
end
