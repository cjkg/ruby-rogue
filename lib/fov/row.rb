class Row
  def initialize(depth, start_slope, end_slope)
    @depth = depth
    @start_slope = start_slope
    @end_slope = end_slope
  end

  def tiles
    min_col = round_ties_up(@depth * @start_slope)
    max_col = round_ties_down(@depth * @end_slope)

    (min_col..max_col).map { |col| [@depth, col] }
  end

  def next
    Row.new(@depth + 1, @start_slope, @end_slope)
  end

  def round_ties_up(n)
    (n + 0.5).floor
  end

  def round_ties_down(n)
    (n - 0.5).ceil
  end

  def start_slope
    @start_slope
  end

  def end_slope
    @end_slope
  end

  def depth
    @depth
  end

  def set_start_slope(slope)
    @start_slope = slope
  end

  def set_end_slope(slope)
    @end_slope = slope
  end
end