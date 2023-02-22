# Class that computes the Field of View (FOV) of a given map from a given point
class ShadowCast
  # Constructor that sets up the map and block to be used in the computation
  def initialize(map, &block)
    @map = map
    @block = block
  end

  # Computes the FOV from the given point (x, y) within the given radius
  def compute(x, y, radius)
    return if x < 0 || y < 0 || x >= @map.width || y >= @map.height

    # Set the starting point to be visible
    @map.get_tile(x, y).set_fov(true)

    # Calculate FOV for each of the eight octants
    8.times do |octant|
      cast_light(1, 1.0, 0.0, 0, radius, octant, x, y)  
    end
  end

  # Calculates the FOV for a given row of the given octant and translates it to the absolute coordinates
  def cast_light(row, start_slope, end_slope, xx, radius, octant, x, y)
    # Return if start slope is less than end slope
    return if start_slope < end_slope

    # Calculate the radius of the row and square of the row
    radius_squared = radius * radius
    row_squared = row * row

    # Iterate over each column of the given row
    -10.upto(row) do |col|

      # Translate the cell from relative to absolute coordinates
      cell = translate(col, row, octant, x, y)

      cell_x = cell[0]
      cell_y = cell[1]

      # If the cell is outside the radius, skip it
      next if cell_x < 0 || cell_y < 0 || cell_x >= @map.width || cell_y >= @map.height
      next if row_squared + col * col > radius_squared

      # Calculate the slopes of the left and right edges of the cell
      left_slope = (col - 0.5) / (row + 0.5)
      right_slope = (col + 0.5) / (row - 0.5)

      next if start_slope < right_slope
      next if end_slope < left_slope
    
      # Mark the cell as visible and call the block if provided
      @map.get_tile(cell_x, cell_y).set_fov(true)
      @block.call(cell_x, cell_y) if @block

      # If the cell blocks sight, skip it
      next if @map.get_tile(cell_x, cell_y).blocks_sight?

      # If the next row is a blocking cell, skip it
      next if @map.get_tile(cell_x + xx, cell_y + 1).blocks_sight?

      # Recursively cast the next row
      cast_light(row + 1, start_slope, left_slope, 1, radius, octant, x, y) if start_slope < left_slope
    end
  end

  # Translates the given (col, row) coordinates of an octant to the absolute coordinates of the map
  def translate(col, row, octant, x, y)
    translations = {
      0 => [x + col, y - row],
      1 => [x + row, y - col],
      2 => [x - row, y - col],
      3 => [x - col, y - row],
      4 => [x - col, y + row],
      5 => [x - row, y + col],
      6 => [x + row, y + col],
      7 => [x + col, y + row]
    }
    translations[octant]
  end
end