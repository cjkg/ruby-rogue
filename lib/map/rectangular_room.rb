require_relative "./room"

class RectangularRoom < Room
  attr_accessor :x1, :y1, :x2, :y2, :width, :height
  def initialize(x, y, width, height)
    @x1 = x
    @y1 = y
    @width = width
    @height = height
    @x2 = x + width
    @y2 = y + height
  end

  def inner
    # Get the inner coordinates of the room.
    xs = ((@x1 + 1)..(@x2)).to_a
    ys = ((@y1 + 1)..(@y2)).to_a

    # Get the Cartesian product of the two arrays
    xs.product(ys)
  end

  def intersects?(other)
    # Return true if this room intersects with another one.
    (@x1 <= other.x2) && (@x2 >= other.x1) && (@y1 <= other.y2) && (@y2 >= other.y1)
  end

  def point_intersects?(x, y)
    # Return true if the given point intersects with this room.
    (x >= @x1) && (x <= @x2) && (y >= @y1) && (y <= @y2)
  end
end