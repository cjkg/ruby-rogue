module InitializeColors
  # Thanks to Alex Smith: http://nethack4.org/blog/portable-terminal-codes.html
  def colors
    {
    "DarkRed" => [124, [175, 0, 0]],
    "DarkGreen" => [28, [0, 135, 0]],
    "Brown" => [130, [175, 95, 0]],
    "DarkBlue" => [19, [0, 0, 175]],
    "DarkMagenta" => [90, [135, 0, 135]],
    "DarkCyan" => [36, [0, 175, 135]],
    "Grey" => [145, [175, 175, 175]],
    "DarkGrey" => [59, [95, 95, 95]],
    "Orange" => [202, [255, 95, 0]],
    "BrightGreen" => [46, [0, 255, 0]],
    "Yellow" => [226, [255, 255, 0]],
    "BrightBlue" => [99, [135, 95, 255]],
    "BrightMagenta" => [205, [255, 95, 175]],
    "BrightCyan" => [45, [0, 215, 255]],
    "White" => [231, [255, 255, 255]],
    "Black" => [0, [0, 0, 0]],
    }
  end

  def initialize_colors
    colors.each do |color, value|
      init_color(value[0], value[1][0], value[1][1], value[1][2])
    end
  end
end