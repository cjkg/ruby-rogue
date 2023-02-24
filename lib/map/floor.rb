require_relative "tile"

class Floor < Tile
  def initialize
    super(".", true, false, COLOR_YELLOW, COLOR_BLUE)
  end
end
