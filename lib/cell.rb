require './lib/ship'

class Cell
  attr_reader :coordinate,
              :ship,
              :status

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
    if @ship && @ship.sunk?
      @status = "X"
    elsif @ship != nil
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

  def status_feedback
    if @status == "M"
      "Miss"
    elsif @status == "H"
      "Hit"
    elsif @status == "X"
      "Hit! The ship is sinking!"
    end
  end
end
