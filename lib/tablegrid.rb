class TableGrid
  attr_accessor :width, :height, :minx, :max_x, :min_y, :max_y

  def initialize(width, height)
    @width  = width
    @height = height
    @min_x  = 0
    @max_x  = width - 1
    @min_y  = 0
    @max_y  = height - 1
    self
  end

  def within_limits(target_x, target_y)
    (0...@width).include? target_x and (0...@height).include? target_y
  end
end