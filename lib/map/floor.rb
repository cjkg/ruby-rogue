require_relative "tile"

class Floor < Tile
  def initialize
    super(".", true, false, COLOR_WHITE, COLOR_BLUE)
  end
end
