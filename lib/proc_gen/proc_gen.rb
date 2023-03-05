require 'set'

class ProcGen
  def initialize(map)
    @map = map
    @visited = {}
    @maze = []
    @regions = []
    build_neighbor_map
  end

  def make_dungeon_floor(max_rooms, room_min_size, room_max_size)
    @rooms = make_dungeon_rooms(max_rooms, room_min_size, room_max_size)
    @map.carve_rooms(@rooms)
    @maze = make_maze
    @map.carve_maze(@maze)
    connect_regions
    remove_dead_ends
  end

  private

  def make_dungeon_rooms(max_rooms, room_min_size, room_max_size)
    room_arr = []

    max_rooms.times do
      room_width = rand(room_min_size..room_max_size)
      room_height = rand(room_min_size..room_max_size)
      
      x = rand(0..@map.width - room_width - 1)
      y = rand(0..@map.height - room_height - 1)

      new_room = RectangularRoom.new(x, y, room_width, room_height)

      next if room_arr.any? { |n| n.intersects?(new_room) }

      room_arr << new_room
      @regions << new_room.full
    end
    room_arr
  end

  def make_maze
    @map.tiles.each_with_index do |tile, index|
      coords = @map.coordinates(index)
      @visited[coords] = @rooms.any? { |room| room.point_intersects?(coords[0], coords[1]) }
    end

    @map.tiles.each_with_index do |tile, index|
      coords = @map.coordinates(index)
      next if @visited[coords]

      x, y = coords

      candidates = get_cardinal_cell_available_neighbors(x, y)

      next if candidates.empty?
      x2, y2 = candidates.sample

      get_next_cell(x, y, x2, y2)
    end
    @maze
  end

  def get_direction(x, y, x2, y2)
    dxy = [x2 - x, y2 - y]

    case dxy
    when [0, -1]
      "North"
    when [0, 1]
      "South"
    when [-1, 0]
      "West"
    when [1, 0]
      "East"  
    end
  end

  def build_neighbor_map
    @neighbor_map = {}
    @map.tiles.each_with_index do |tile, index|
      coords = @map.coordinates(index)
      @neighbor_map[coords] = cardinal_neighbors_for_map(coords[0], coords[1])
    end
  end

  def build_region_hash
    @region_hash = {}
    @map.tiles.each_with_index do |tile, index|
      coords = @map.coordinates(index)
      x, y = coords
      next if @map.floor?(x, y)
      @region_hash[coords] = get_region(x, y)
    end
    @region_hash
  end

  def get_region(x, y)
    tmp_regions = []
    @regions.each do |region|
      tmp_regions << region if region.include?([x, y])
    end
    tmp_regions
  end

  def cardinal_neighbors_for_map(x, y)
    [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]] # N, S, W, E
  end

  def get_cardinal_cell_neighbors(x, y)
    @neighbor_map[[x, y]]
  end

  def get_cardinal_cell_available_neighbors(x, y)
    get_cardinal_cell_neighbors(x, y).select { |n| !@visited[n] && !@map.out_of_bounds?(n[0], n[1]) }
  end

  def get_all_cell_neighbors(x, y)
    [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y], [x - 1, y - 1], [x + 1, y - 1], [x - 1, y + 1], [x + 1, y + 1]]
  end 

  def get_next_cell(x, y, x2, y2)
    region = []
    loop do
      @maze << [x, y]
      region << [x, y]
      @visited[[x, y]] = true

      dir = get_direction(x, y, x2, y2) # get direction to next cell

      case dir
      when "North", "South"
        @visited[[x - 1, y]] = true
        region << [x - 1, y]

        @visited[[x + 1, y]] = true
        region << [x + 1, y]
      when "West", "East"
        @visited[[x, y - 1]] = true
        region << [x, y - 1]

        @visited[[x, y + 1]] = true
        region << [x, y + 1]
      end
    
      candidates = get_cardinal_cell_available_neighbors(x2, y2)
    
      break if candidates.empty?

      x, y = x2, y2
      x2, y2 = candidates.sample
    end
    @regions << region
  end

  def remove_dead_ends
    done = false

    until done

      done = true
      @map.tiles.each_with_index do |tile, index|
        x, y = @map.coordinates(index)
        next if @map.wall?(x, y)

        exits = 0

        get_cardinal_cell_neighbors(x, y).each do |neighbor|
          nx, ny = neighbor
          exits += 1 if @map.floor?(nx, ny)
        end

        next if exits > 1

        done = false
        @map.uncarve_tile(x, y)  # change to maze
      end
    end
  end

  def connect_regions
    region_hash = build_region_hash 

    @map.tiles.each_with_index do |tile, index|
      x, y = @map.coordinates(index)
      next if @map.floor?(x, y)
      region_hash.delete([x, y]) if region_hash[[x, y]].length < 2
    end

    connectors = region_hash.keys
    
  end
end