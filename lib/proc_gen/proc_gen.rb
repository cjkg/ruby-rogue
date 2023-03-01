module ProcGen
  def make_dungeon_floor(map, max_rooms, room_min_size, room_max_size)
    rooms = make_dungeon_rooms(map, max_rooms, room_min_size, room_max_size)
    map.carve_rooms(rooms)
    maze = make_maze(map, rooms)
    map.carve_maze(maze)
  end

  def make_dungeon_rooms(map, max_rooms, room_min_size, room_max_size)
    room_arr = []

    max_rooms.times do
      room_width = rand(room_min_size..room_max_size)
      room_height = rand(room_min_size..room_max_size)
      
      x = rand(0..map.width - room_width - 1)
      y = rand(0..map.height - room_height - 1)

      new_room = RectangularRoom.new(x, y, room_width, room_height)

      next if room_arr.any? { |n| n.intersects?(new_room) }

      room_arr << new_room
    end
    room_arr
  end

  def make_maze(map, rooms)
    maze = []
    visited = {}
    good_tiles = []
    map.tiles.each_with_index do |tile, index|
      next if tile.is_a?(Floor)
      coords = map.coordinates(index)
      x = coords[0]
      y = coords[1]
      next if rooms.any? { |room| room.point_intersects?(x, y) }
      good_tiles << coords
    end
    
    start = good_tiles.sample
    visited[start] = true
    maze << start
    maze
  end
end