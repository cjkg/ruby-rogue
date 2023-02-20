require_relative "floor"

class GameMap
  def initialize(width, height)
    @width = width
    @height = height
    @tiles = Array.new(width) do
      Array.new(height) do
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
