class Tile
  def initialize(char, walkable=true, blocks_sight=false, color=COLOR_WHITE, dark_color=COLOR_BLACK)
    @char = char
    @walkable = walkable
    @blocks_sight = blocks_sight
    @explored = false
    @light = false
    @color = color
  end

  def char
    @char
  end

  def color
    @color
  end

  def walkable?
    @walkable
  end

  def blocks_sight?
    @blocks_sight
  end

  def explored?
    @explored
  end
  
  def light?
    @light
  end

  def set_explored
    @explored = true
  end

  def set_light
    @light = true
  end

  def set_dark
    @light = false
  end
end
