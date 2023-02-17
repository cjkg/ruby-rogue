require_relative "./utils/rng/die"
require_relative "./utils/rng/bag"

require "curses"
include Curses

begin
  init_screen
  getch
ensure
  close_screen
end