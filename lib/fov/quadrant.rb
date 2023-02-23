class Quadrant
  @@north = 0
  @@east = 1
  @@south = 2
  @@west = 3

  def initialize(cardinal, x, y)
    @cardinal = cardinal
    @x = x
    @y = y
  end

  def transform(row, col)
    case @cardinal
    when @@north
      return @x + col, @y - row
    when @@south
      return @x + col, @y + row
    when @@east
      return @x + row, @y + col
    when @@west
      return @x - row, @y + col
    end
  end
end
