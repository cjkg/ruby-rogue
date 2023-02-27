require_relative "ui/curses_ui/curses_renderer"
require_relative "ui/curses_ui/curses_input_handler"
require_relative "entity/player"
require_relative "map/game_map"
require_relative "utils/initialize_colors"
require_relative "fov/shadow_cast"

require "curses"

include Curses
include InitializeColors

MAP_WIDTH = 80
MAP_HEIGHT = 24
FLOOR = 1
init_screen
start_color

curs_set(0)
noecho
initialize_colors
 
renderer = CursesRenderer.new
input = CursesInputHandler.new

begin
  start_x = 10
  start_y = 10
  player = Player.new(start_x, start_y, "@", 0, "Hero", 5)
  entities = [player]
  map = GameMap.new(MAP_WIDTH, MAP_HEIGHT, 1)
  shadow = ShadowCast.new(map)

  while true do
    action = input.handle_keys # TODO : This should be rethought

    move = action["move"]
    quit = action["quit"]

    if move && player.can_move?(move["dx"], move["dy"], map)
      player.move(move["dx"], move["dy"])
      shadow.compute(player.x, player.y, player.fov)
      map.dijkstra_map(player.x, player.y)
      renderer.clear_entities(entities)
      renderer.render_map(map)
      renderer.render_entities(entities)
    elsif quit
      break
    end
  end

ensure
  close_screen
end
