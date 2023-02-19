require_relative "./utils/rng/die"
require_relative "./utils/rng/bag"
require "./ui/curses_ui/curses_renderer"
require "./ui/curses_ui/curses_input_handler"
require "./entity/player"

require "curses"

include Curses


init_screen
start_color
curs_set(0)
noecho
renderer = CursesRenderer.new
input = CursesInputHandler.new
CUSTOM_YELLOW = 11
CUSTOM_RED = 196
CUSTOM_DARK_RED = 124
CUSTOM_DARKER_RED = 88
CUSTOM_DARKEST_RED = 52
CUSTOM_BLUE = 21
CUSTOM_DARK_BLUE = 20
CUSTOM_DARKER_BLUE = 19
CUSTOM_DARKEST_BLUE = 18
CUSTOM_GREEN = 40
CUSTOM_DARK_GREEN = 34
CUSTOM_DARKER_GREEN = 28
CUSTOM_DARKEST_GREEN = 22
CUSTOM_ORANGE = 202
CUSTOM_DARK_ORANGE = 166
CUSTOM_DARKER_ORANGE = 130
CUSTOM_DARKEST_ORANGE = 94
CUSTOM_PURPLE = 165
CUSTOM_DARK_PURPLE = 129
CUSTOM_DARKER_PURPLE = 93
CUSTOM_DARKEST_PURPLE = 57
CUSTOM_GRAY = 8
CUSTOM_DARK_GRAY = 59
CUSTOM_DARKER_GRAY = 236
CUSTOM_DARKEST_GRAY = 237
CUSTOM_WHITE = 15
CUSTOM_BLACK = 0
CUSTOM_BROWN = 94
CUSTOM_DARK_BROWN = 52
CUSTOM_DARKER_BROWN = 130
CUSTOM_DARKEST_BROWN = 94

init_pair(01, 1, 0)

begin
  
  start_x = 10
  start_y = 10
  player = Player.new(start_x, start_y, "@", 0, "Hero")
  entities = [player]

  while true do
    action = input.handle_keys
    move = action["move"] || nil
    quit = action["quit"] || nil

    if move
      player.move(move["dx"], move["dy"])
    elsif quit
      break
    end

    if action
      renderer.render_entities(entities)
    end
  end

ensure
  close_screen
end
