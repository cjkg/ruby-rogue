class CursesInputHandler
  def new
  end

  def handle_keys
    ch = Curses.getch
    output = case ch
    when "w"
      {"move" => {"dx" => 0, "dy" => -1}}
    when "s"
      {"move" => {"dx" => 0, "dy" => 1}}
    when "a"
      {"move" => {"dx" => -1, "dy" => 0}}
    when "d"  
      {"move" => {"dx" => 1, "dy" => 0}}
    when "q"
      {"quit" => true}
    else
      {}
    end
    output
  end
end