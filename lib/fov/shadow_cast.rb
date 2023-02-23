# Class that computes the Field of View (FOV) of a given map from a given point
class ShadowCast
  # Constructor that sets up the map and block to be used in the computation
  def initialize(map, &block)
    @map = map
    @block = block
  end

  # Computes the FOV of the map from the given point
  def compute(x, y, radius)
    return if x < 0 || y < 0 || x >= @map.width || y >= @map.height

    # Set the starting point to be visible
    @map.get_tile(x, y).set_fov(true)

    1..4.each do |octant|
end