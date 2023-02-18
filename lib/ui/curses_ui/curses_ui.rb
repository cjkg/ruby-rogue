require "curses"
include Curses

class CursesUi
  # render in order from RenderOrder
  
  def new
  end
  
  def render_entities(entities)
    entities.each do |entity|
      setpos(entity.y, entity.x)
      attrset(color_pair(entity.color))
      addch(entity.char)  
      # Curses.attroff(color_pair(entity.color))
    end
  end

  def clear_entities(entities)
    entities.each do |entity|
      setpos(entity.y, entity.x)
      addch(" ")
    end
  end
    
end 