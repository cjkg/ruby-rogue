require_relative "./room"

class RectangularRoom < Room
  def initialize(x, y, width, height)
    @x1 = x
    @y1 = y
    @width = width
    @height = height
    @x2 = x + width
    @y2 = y + height
  end

  def center
    center_x = (@x1 + @x2) / 2
    center_y = (@y1 + @y2) / 2
    [center_x, center_y]
  end

  def inner
    
  end
end