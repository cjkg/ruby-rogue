require_relative "floor"

class GameMap
  def initialize(width, height)
    @width = width
    @height = height
    @tiles = Array.new(height) do
      Array.new(width) do
        Floor.new
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
end
