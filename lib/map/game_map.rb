require_relative "floor"
require_relative "wall"

class GameMap
  def initialize(width, height)
    @width = width
    @height = height
    @tiles = Array.new(height) do
      Array.new(width) do
        rand(0..100) < 1 ? Wall.new : Floor.new      
      end 
    end
  end

  def width
    @width
  end

  def height
    @height
  end

  def tiles
    @tiles
  end

  def get_tile(x, y)
    @tiles[y][x]
  end
end
