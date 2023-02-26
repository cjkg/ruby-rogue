class Row
  attr_accessor :depth, :start_slope, :end_slope
  def initialize(depth, start_slope, end_slope)
    @depth = depth
    @start_slope = start_slope
    @end_slope = end_slope
  end

  def tiles
    # Get the tiles in this row
    min_col = round_ties_up(@depth * @start_slope)
    max_col = round_ties_down(@depth * @end_slope)

    (min_col..max_col).map { |col| [@depth, col] }
  end

  def next
    # Start a new row
    Row.new(@depth + 1, @start_slope, @end_slope)
  end

  def round_ties_up(n)
    # Special rounding function that rounds up when the number is halfway between two integers in the case of a tie
    (n + 0.5).floor
  end

  def round_ties_down(n)
    # Special rounding function that rounds down when the number is halfway between two integers in the case of a tie
    (n - 0.5).ceil
  end
end