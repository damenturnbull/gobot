class TableGrid
  attr_accessor :width, :height, :max_x, :max_y

  def initialize(width, height)
    @width  = width
    @height = height
    @max_x  = @width  - 1
    @max_y  = @height - 1
  end

  def within_limits(target_x, target_y)
    within_x target_x and within_y target_y
  end

  def within_x(target_x)
    (0...@width).include? target_x
  end

  def within_y(target_y)
    (0...@height).include? target_y
  end
end