class Cell
  attr_reader :location,
              :ship
              
  def initialize(location, ship = nil)
    @location = location
    @ship = ship
  end
end
