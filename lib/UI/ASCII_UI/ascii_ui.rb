require "curses"
include Curses

class AsciiUi
  # render in order from RenderOrder
  
  def new
  end
  
  def render_entities(entities)
    entities.each do |entity|
      setpos(entity.y, entity.x)
      Curses.attron(color_pair(entity.color))
      addch(entity.char)
      Curses.attroff(color_pair(entity.color))
    end
  end

  def clear_entities(entities)
    entities.each do |entity|
      setpos(entity.y, entity.x)
      addch(" ")
    end
  end
end