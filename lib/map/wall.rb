require_relative "tile"

class Floor < Tile
  def initialize
    super("#", false, true, COLOR_WHITE, COLOR_BLUE)
  end
end
