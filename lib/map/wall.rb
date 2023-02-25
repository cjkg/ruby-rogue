require_relative "tile"

class Wall < Tile
  def initialize
    super("#", false, true, COLOR_YELLOW, COLOR_BLUE)
  end
end
