require './lib/ship'

class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate, ship = nil)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
    @status = "."
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    @ship.hit if @ship != nil
    if @ship != nil
      @status = "H"
    else
      @status = "M"
    end
  end

  def render(see_ship = false)
    if @ship && @ship.sunk?
      @status = "X"
    elsif see_ship == true && @ship && @fired_upon == false
      @status = "S"
    else
      @status
    end
  end
end
