require_relative "../utils/map_utils"

include MapUtils

class Entity
  def initialize(x, y, char, color, name, fov)
    @x = x
    @y = y
    @char = char
    @color = color
    @name = name
    @fov = fov
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

  def fov
    @fov
  end

  def set_fov(fov)
    @fov = fov
  end

  def set_char(char)
    @char = char
  end

  def move dx, dy
    @x += dx
    @y += dy
  end

  def can_move?(dx, dy)
    in_bounds?(dx, dy)
  end

  def set_color color
    @color = color
  end
end
