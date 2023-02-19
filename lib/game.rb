require "./ui/curses_ui/curses_renderer"
require "./ui/curses_ui/curses_input_handler"
require "./entity/player"

require "curses"

include Curses

MAP_WIDTH = 80
MAP_HEIGHT = 24

init_screen
start_color
curs_set(0)
noecho

renderer = CursesRenderer.new
input = CursesInputHandler.new

begin
  start_x = 10
  start_y = 10
  player = Player.new(start_x, start_y, "@", 0, "Hero")
  entities = [player]

  while true do
    action = input.handle_keys
    move = action["move"]
    quit = action["quit"]

    if move && player.can_move?(move["dx"], move["dy"])
      renderer.clear_entities(entities)
      player.move(move["dx"], move["dy"])
      renderer.render_entities(entities)
    elsif quit
      break
    end
  end

ensure
  close_screen
end
