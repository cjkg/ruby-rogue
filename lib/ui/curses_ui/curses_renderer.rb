require "curses"
include Curses

class CursesRenderer
  # render in order from RenderOrder
  
  def new
  end
  
  def render_entities(entities)
    entities.each do |entity|
      attrset(color_pair(entity.color))
      setpos(entity.y, entity.x)
      addch(entity.char)
      attroff(color_pair(entity.color))
    end
  end

  def clear_entities(entities)
    entities.each do |entity|
      setpos(entity.y, entity.x)
      attron(color_pair(0))
      addch(" ")
    end
  end
end
