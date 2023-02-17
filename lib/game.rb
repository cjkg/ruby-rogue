require_relative "./utils/rng/die"
require_relative "./utils/rng/bag"
require "./UI/ASCII_UI/ascii_ui"
require "./entity/player"

require "curses"

include Curses

init_screen
start_color
curs_set(0)
noecho

init_pair(1, 1, 0)

begin
  ui = AsciiUi.new
  start_x = 10
  start_y = 10
  player = Player.new(start_x, start_y, "@", 1, "Hero")
  entities = [player]

  while getch != "q" do
    ui.render_entities(entities)
  end

ensure
  close_screen
end