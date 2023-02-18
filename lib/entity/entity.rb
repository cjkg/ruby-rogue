class Entity
  def initialize x, y, char, color, name
    @x = x
    @y = y
    @char = char
    @color = color
    @name = name
  end

  def x
    @x
  end

  def y
    @y
  end

  def char
    @char
  end

  def color
    @color
  end

  def name
    @name
  end

  def move dx, dy
    @x += dx
    @y += dy
  end
end