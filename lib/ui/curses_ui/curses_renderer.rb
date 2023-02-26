require "curses"
include Curses

class CursesRenderer
  # render in order from RenderOrder
  
  def new
  end
  
  def render_entities(entities)
    entities.each do |entity|
      render_entity(entity)
    end
  end

  def clear_entities(entities)
    entities.each do |entity|
      clear_entity(entity)
    end
  end

  def render_map(map)
    map.tiles.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        next if map.out_of_bounds?(x, y) || !map.explored?(x, y)
        render_map_tile(tile, x, y)
      end
    end
  end

private

  def render_map_tile(tile, x, y)
    if tile.fov?
      tile.color != 3 ? attrset(color_pair(tile.color)) : attrset(color_pair(tile.color) | A_BOLD) # TODO Fix this, dear god
      setpos(y, x)
      addch(tile.char)
      attroff(color_pair(tile.color)) 
    else #explored but not in fov
      attrset(color_pair(tile.dark_color))
      setpos(y, x)
      addch(tile.char)
      attroff(color_pair(tile.dark_color))
    end
  end

  def render_entity(entity)
    attrset(color_pair(entity.color))
    setpos(entity.y, entity.x)
    addch(entity.char)
    attroff(color_pair(entity.color))
  end

  def clear_entity(entity)
    setpos(entity.y, entity.x)
    attron(color_pair(0))
    addch(" ")
    attroff(color_pair(0))
  end

  # TODO: abstract away the Curses calls for character painting
end
