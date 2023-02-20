require_relative "tile"

class Floor < Tile
  def initialize
    super(".", true, false)
  end
end
