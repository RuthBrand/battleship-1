Ship Class

  Method Initialize
    -initialize a new ship object
  Attributes
    -has a name
    -has a length
    -has a current health
    -has a record of hits
    -knows if it is sunk or not

  Method Sunk?
    -evaluate if ship object has been sunk or not, depending on hits/health

  Method Hit
    -takes health away from ship object
    -changes the current health each time this method is called
    -changes the record of hits each time this method is called
---------------------------
Cell Class

  Method Initialize
    -initialize a new cell with a grid location
  Attributes
    -contains a ship, or does not
    -contains its grid location

  Method ship
    -returns the ship object of the cell

  Method empty?
    -returns true or false depending on if that cell has a ship

  Method place_ship(ship)
    -places the ship that you feed into this method, into the cell that you are calling this method on

  Method fired_upon?
    -returns a boolean if the cell has been fired on.

  Method fire_upon
    -changes the value of fired_upon to true
    -the ship object in the cell, should decrease its health by 1 each time this method is called
------------------------
Board Class
