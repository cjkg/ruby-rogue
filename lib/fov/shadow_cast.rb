require_relative "./quadrant"
require_relative "./row"
require_relative "../map/game_map"

# Class that computes the Field of View (FOV) of a given map from a given point
class ShadowCast
  # Constructor that sets up the map and block to be used in the computation
  def initialize(map)
    @map = map
  end

  # Computes the FOV of the map from the given point
  def compute(x, y, radius)
    return if x < 0 || y < 0 || x >= @map.width || y >= @map.height

    # Set the starting point to be visible
    @map.get_tile(x, y).set_fov(true)

    (0..3).each do |quadrant|
      quadrant = Quadrant.new(quadrant, x, y)
      first_row = Row.new(1, -1, 1)
      scan(first_row, quadrant)
    end
  end

  def scan(row, quadrant)
    prev_tile = nil
    row.tiles.each do |row_tile|
      map_tile_x, map_tile_y = quadrant.transform(row_tile[0], row_tile[1])
      map_tile = @map.get_tile(map_tile_x, map_tile_y)
        
      map_tile.set_fov(true) if map_tile.blocks_sight?
  
      row.start_slope = slope(row_tile[0], row_tile[1]) if prev_tile.blocks_sight? && map_tile.walkable?
      
      if prev_tile.walkable? && map_tile.blocks_sight?
        next_row = row.next
        next_row.end_slope = slope(row_tile[0], row_tile[1])
        scan(next_row, quadrant)
      end
    end

    if prev_tile.floor?
      scan(row.next, quadrant)
    end
  end

  def slope(tile_x, tile_y)
    return Rational(2 * tile_y - 1, 2 * tile_x)
  end

  def is_symmetric(row, tile_x, tile_y)
    row_depth = tile_x
    col = tile_y
    
    col >= row_depth * row.start_slope && col <= row_depth * row.end_slope
  end
end
