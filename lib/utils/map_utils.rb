module MapUtils
  def in_bounds?(dx, dy)
    @x + dx >= 0 && @y + dy >= 0 && @x + dx < MAP_WIDTH && @y + dy < MAP_HEIGHT
  end
end