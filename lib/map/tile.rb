class Tile
  attr_accessor :char, :walkable, :blocks_sight, :explored, :light, :color, :fov, :dark_color
  def initialize(char, walkable=true, blocks_sight=false, color=COLOR_WHITE, dark_color=COLOR_BLACK)
    @char = char
    @walkable = walkable
    @blocks_sight = blocks_sight
    @explored = false
    @light = false
    @color = color
    @fov = false
    @dark_color = dark_color
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

  def fov?
    @fov
  end
end
