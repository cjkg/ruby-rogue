require_relative "floor"
require_relative "wall"

class GameMap
  def initialize(width, height)
    @width = width
    @height = height
    @tiles = Array.new(height) do
      Array.new(width) do
        rand(0..100) < 10 ? Wall.new : Floor.new      
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

  def out_of_bounds?(x, y)
    x < 0 || y < 0 || x >= @width || y >= @height
  end

  def distance(x1, y1, x2, y2)
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2)
  end
end
