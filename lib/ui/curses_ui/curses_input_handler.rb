class CursesInputHandler
  def new
  end

  def handle_keys
    ch = Curses.getch
    output = case ch.downcase  
    when "w", "k"
      {"move" => {"dx" => 0, "dy" => -1}}
    when "s", "j"
      {"move" => {"dx" => 0, "dy" => 1}}
    when "a", "h"
      {"move" => {"dx" => -1, "dy" => 0}}
    when "d", "l" 
      {"move" => {"dx" => 1, "dy" => 0}}
    when "q"
      {"quit" => true}
    else
      {}
    end
    output
  end
end