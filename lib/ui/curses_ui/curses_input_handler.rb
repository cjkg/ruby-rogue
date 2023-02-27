class CursesInputHandler
  def new
  end

  def handle_keys
    ch = Curses.getch
    output = case ch
    when "w", "W", "k", "K"
      {"move" => {"dx" => 0, "dy" => -1}}
    when "s", "S", "j", "J"
      {"move" => {"dx" => 0, "dy" => 1}}
    when "a", "A", "h", "H"
      {"move" => {"dx" => -1, "dy" => 0}}
    when "d", "D" "l", "L" 
      {"move" => {"dx" => 1, "dy" => 0}}
    when "q", "Q"
      {"quit" => true}
    else
      {}
    end
    output
  end
end