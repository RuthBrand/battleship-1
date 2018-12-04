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

  def test_it_can_have_a_different_coordinate
    cell = Cell.new("A2")

    assert_equal "A2", cell.coordinate
  end

  def test_if_have_ship
    cell = Cell.new("B4")

    # ruby is recommending assert_nil
    assert_equal nil, cell.ship
  end

  def test_if_empty?
    cell = Cell.new("B4")

    assert_equal true, cell.empty?

    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal false, cell.empty?
  end

  def test_place_ship_method
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship

    submarine = Ship.new("Submarine", 2)
    cell.place_ship(submarine)

    assert_equal submarine, cell.ship
  end

  def test_if_cell_has_been_fired_upon
    cell = Cell.new("D1")

    assert_equal false, cell.fired_upon?
  end

  def test_cell_can_be_fired_upon
    cell = Cell.new("A1")
    cell.fire_upon

    assert_equal true, cell.fired_upon?
  end
end
