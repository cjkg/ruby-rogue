module GeometryUtils
  def bresenham_line(x1, x2, y1, y2)
    line = []
    
    dx = (x2 - x1).abs
    dy = (y2 - y1).abs
    
    #is the line moving left or right?
    sx = x1 < x2 ? 1 : -1
    #is the line moving up or down?
    sy = y1 < y2 ? 1 : -1

    err = dx - dy

    while x1 != x2 || y1 != y2
      line << [x1, y1]
      e2 = 2 * err

      if e2 > -dy
        err -= dy
        x1 += sx
      end

      if e2 < dx
        err += dx
        y1 += sy
      end  
    end
    line << [x2, y2]
    line
  end
end
