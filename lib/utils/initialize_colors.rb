include Curses

module InitializeColors
  def initialize_colors

    # TODO Have some logic that looks for what colors are available and then set accordingly
    init_pair(0, Curses::COLOR_BLACK, Curses::COLOR_BLACK)
    init_pair(1, Curses::COLOR_RED, Curses::COLOR_BLACK)
    init_pair(2, Curses::COLOR_GREEN, Curses::COLOR_BLACK)
    init_pair(3, Curses::COLOR_YELLOW, Curses::COLOR_BLACK)
    init_pair(4, Curses::COLOR_BLUE, Curses::COLOR_BLACK)
    init_pair(5, Curses::COLOR_MAGENTA, Curses::COLOR_BLACK)
    init_pair(6, Curses::COLOR_CYAN, Curses::COLOR_BLACK)
    init_pair(7, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
  end
end
