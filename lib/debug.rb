require_relative "ui/curses_ui/curses_renderer"
require_relative "ui/curses_ui/curses_input_handler"
require_relative "entity/player"
require_relative "map/game_map"
require_relative "proc_gen/proc_gen"
require_relative "utils/initialize_colors"
require_relative "fov/shadow_cast"
include ProcGen
MAP_WIDTH = 80
MAP_HEIGHT = 24

map = GameMap.new(MAP_WIDTH, MAP_HEIGHT, 1)
make_dungeon_floor(map, 100, 5, 10)
