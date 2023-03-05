require_relative "floor"
require_relative "wall"
require_relative "rectangular_room"

class GameMap
  attr_accessor :width, :height, :tiles, :grid
  def initialize(width, height, floor)
    @width = width
    @height = height
    @floor = floor
    make_map
    build_floor_grid
  end

  # Map generation

  def make_map
    # Create an array of tiles and fill it with floor tiles.
    @tiles = Array.new(@width * @height) { Wall.new }
  end

  def carve_tile(x, y)
    # Set the tile at the given coordinates to a floor tile.
    @tiles[index(x, y)] = Floor.new
  end

  def uncarve_tile(x, y)
    # Set the tile at the given coordinates to a wall tile.
    @tiles[index(x, y)] = Wall.new
  end

  def carve_rooms(room_arr)
    room_arr.each do |room|
      room.inner.each do |x, y|
        carve_tile(x, y)
      end
    end
  end

  def carve_maze(maze)
    maze.each do |tile|
      carve_tile(tile[0], tile[1])
    end
  end

  # Helper methods

  def get_tile(x, y)
    # Grab the tile at the given coordinates.
    @tiles[index(x, y)]
  end

  def floor?(x, y)
    # Check if the tile at the given coordinates is a floor tile.
    get_tile(x, y).is_a?(Floor)
  end

  def wall?(x, y)
    # Check if the tile at the given coordinates is a wall tile.
    get_tile(x, y).is_a?(Wall)
  end

  def explored?(x, y)
    # Check if the tile at the given coordinates has been explored.
    @explored&.has_key?([x, y])
  end

  def fov?(x, y)
    # Check if the tile at the given coordinates is in the player's field of view.
    @fov&.has_key?([x, y])
  end

  def out_of_bounds?(x, y)
    # Check if the coordinates are outside the bounds of the map.
    @out_of_bounds ||= {}
    @out_of_bounds[[x, y]] ||= x < 0 || y < 0 || x >= @width || y >= @height
  end
  
  def distance(x1, y1, x2, y2)
    # Calculate the euclidean distance between two points.
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2)
  end

  def dijkstra_map(start_x, start_y)
    # TODO: figure out a way to remake the floor grid when a wall gets destroyed
    # build_floor_grid

    # Initialize the distances array with all distances set to infinity.
    @distances = Array.new(@width * @height, Float::INFINITY)

    # Set the distance of the starting cell to 0.
    @distances[index(start_x, start_y)] = 0
  
    # Create a priority queue to store the nodes to explore, ordered by distance.
    # TODO: Use a binary heap instead of an array. Or a real priority queue, no real gems available.
    pq = [[start_x, start_y, 0]]
  
    # Process nodes in the priority queue until it is empty.
    until pq.empty?
      # Get the node with the smallest distance from the priority queue.
      node_x, node_y, node_dist = pq.shift

      # Check the neighboring cells of the current node.
      [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dx, dy|
        neighbor_x, neighbor_y = node_x + dx, node_y + dy
  
        # Skip the neighbor if it is out of bounds or impassable.
        next if out_of_bounds?(neighbor_x, neighbor_y) ||
          !@grid[neighbor_x, neighbor_y]
  
        # Get the index of the neighbor in the distances array.
        neighbor_index = index(neighbor_x, neighbor_y)
        
        # Calculate the distance to the neighbor through the current node.
        neighbor_dist = node_dist + 1
  
        # Update the neighbor's distance if it is lower than the current value.
        if neighbor_dist < @distances[neighbor_index]
          @distances[neighbor_index] = neighbor_dist
          pq.push([neighbor_x, neighbor_y, neighbor_dist])
        end
      end
    end

    @distances
  end

  def reset_fov
    # Reset the field of view.
    @fov = {}
  end

  def set_fov_tile(x, y)
    # Set a tile as visible in the field of view.
    @fov ||= {}
    @fov[[x, y]] = true
  end

  def set_explored_tile(x, y)
    # Set a tile as explored.
    @explored ||= {}
    @explored[[x, y]] = true
  end

  def index(x, y)
    # Get the index of a cell in the a 1D map array.
    y * @width + x
  end  

  def coordinates(i)
    # Get the coordinates of a cell in a 1D map array.
    [i % @width, i / @width]
  end  

  private
  
  def build_floor_grid
    # Create a grid of booleans representing the walkable tiles. Used by dijkstra map.
    @grid = @tiles.map { |tile| tile.walkable? }
  end

end
