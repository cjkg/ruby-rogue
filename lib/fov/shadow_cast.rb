require_relative "./quadrant"
require_relative "./row"
require_relative "../map/game_map"

# Thanks to Albert Ford for his very helpful post/algorithm
# https://www.albertford.com/shadowcasting/

class ShadowCast
  @@quadrants = 0..3

  def initialize(map)
    @map = map
  end

  def compute(x, y, radius)
    #TODO use a bitmask on this
    reset_fov
    return if @map.out_of_bounds?(x, y)

    @map.get_tile(x, y).fov = true

    @@quadrants.each do |quadrant|
      quadrant = Quadrant.new(quadrant, x, y)
      first_row = Row.new(1, -1, 1)
      scan(first_row, quadrant, radius, x, y)
    end
  end

  private

  def reset_fov
    @map.tiles.each do |row|
      row.each do |tile|
        tile.fov = false
      end
    end
  end

  def scan(row, quadrant, radius, origin_x, origin_y)
    prev_tile = nil

    row.tiles.each do |row_tile|
      map_tile_x, map_tile_y = quadrant.transform(row_tile[0], row_tile[1])

      next unless within_radius?(map_tile_x, map_tile_y, origin_x, origin_y, radius)

      next if @map.out_of_bounds?(map_tile_x, map_tile_y)

      map_tile = @map.get_tile(map_tile_x, map_tile_y)
      map_tile_blocks_sight = map_tile.blocks_sight?
      
      if map_tile_blocks_sight || is_symmetric(row, row_tile[0], row_tile[1])
        map_tile.fov = true
        map_tile.explored = true
      end
  
      row.start_slope = slope(row_tile[0], row_tile[1]) if prev_tile&.blocks_sight? && map_tile.walkable?
      
      if prev_tile&.walkable? && map_tile_blocks_sight
        next_row = row.next
        next_row.end_slope = slope(row_tile[0], row_tile[1])
        scan(next_row, quadrant, radius, origin_x, origin_y)
      end

      prev_tile = map_tile
    end

    if prev_tile&.walkable?
      scan(row.next, quadrant, radius, origin_x, origin_y)
    end
  end

  def slope(tile_x, tile_y)
    @slope_cache ||= {}

    key = [tile_x, tile_y]

    if @slope_cache.has_key?(key)
      return @slope_cache[key]
    else
      slope = Rational(2 * tile_y - 1, 2 * tile_x)
      @slope_cache[key] = slope
      return slope
    end
  end

  def is_symmetric(row, tile_x, tile_y)
    row_depth = row.depth
    col = tile_y
    
    col >= row_depth * row.start_slope && col <= row_depth * row.end_slope
  end

  def within_radius?(x, y, origin_x, origin_y, radius)
    @distance_cache ||= {}
    key = [x, y, origin_x, origin_y]
  
    return @distance_cache[key] <= radius if @distance_cache.has_key?(key)
    
    distance = @map.distance(origin_x, origin_y, x, y)
    
    @distance_cache[key] = distance
    
    return distance <= radius
  end
end
