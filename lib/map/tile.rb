class Tile
  attr_accessor :char, :walkable, :blocks_sight, :explored, :color, :fov, :dark_color
  def initialize(char, walkable=true, blocks_sight=false, color=COLOR_WHITE, dark_color=COLOR_BLACK)
    @char = char
    @walkable = walkable
    @blocks_sight = blocks_sight
    @explored = false
    @color = color
    @fov = false
    @dark_color = dark_color
  end

  def walkable?
    # convenience method to check if a tile blocks movement
    @walkable
  end

  def blocks_sight?
    # convenience method to check if a tile blocks sight
    @blocks_sight
  end

  def explored?
    # convenience method to check if a tile has been explored
    @explored
  end

  def fov?
    # convenience method to check if a tile is in the field of view
    @fov
  end
end
