require_relative "floor"
require_relative "wall"
require "matrix"

class GameMap
  attr_accessor :width, :height, :tiles, :grid
  def initialize(width, height, floor)
    @width = width
    @height = height
    @floor = floor
    #TODO make this a 1D array?
    @tiles = Array.new(height) do
      Array.new(width) do
        rand(0..100) < 10 ? Wall.new : Floor.new      
      end 
    end
    @grid = build_floor_grid
  end

  def get_tile(x, y)
    # Grab the tile at the given coordinates.
    @tiles[y][x]
  end

  def explored?(x, y)
    # Check if the tile at the given coordinates has been explored.
    @explored ||= {}
    # Memoize the result.
    @explored[[x, y]] ||= get_tile(x, y).explored?
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
    # Initialize the distances array with all distances set to infinity.
    @distances = Array.new(@width * @height, Float::INFINITY)

    # Set the distance of the starting cell to 0.
    @distances[dijkstra_index(start_x, start_y)] = 0
  
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
        neighbor_index = dijkstra_index(neighbor_x, neighbor_y)
        
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

  private
  
  def build_floor_grid
    # Create a grid of booleans representing the walkable tiles. Used by dijkstra map.

    # Initialize the grid with all cells set to walkable.
    @grid = Array.new(@height) do
      Array.new(@width, true)
    end

    # Set the value of each walkable tile to true.
    @tiles.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        @grid[x, y] = false unless tile.walkable?
      end
    end

    @grid
  end

  def dijkstra_index(x, y)
    # Get the index of a cell in the distances array.
    y * @width + x
  end
  
  def dijkstra_coordinates(i)
    # Get the coordinates of a cell in the distances array.
    [i % @width, i / @width]
  end  
end
