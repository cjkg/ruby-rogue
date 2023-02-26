class Entity
  attr_accessor :x, :y, :char, :color, :name, :fov
  def initialize(x, y, char, color, name, fov)
    @x = x
    @y = y
    @char = char
    @color = color
    @name = name
    @fov = fov
  end

  def move dx, dy
    @x += dx
    @y += dy
  end

  def can_move?(dx, dy, map)
    !map.out_of_bounds?(@x + dx, @y + dy) && tile = map.get_tile(@x + dx, @y + dy).walkable?
  end
end
