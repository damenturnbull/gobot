class Robot
  DIRECTIONS =  {:north => 0, :east => 1, :south => 2, :west => 3}
  attr_reader :position, :direction, :direction_index, :placed

  def initialize
    @placed = false
  end

  def place(position, direction)
    @position         = position
    @direction        = direction
    @direction_index  = DIRECTIONS[@direction.to_sym_down]
    @placed           = true
    self
  end

  def move
    case @direction.to_sym_down
    when :north
      @position.y += 1
    when :east
      @position.x += 1
    when :south
      @position.y -= 1
    when :west
      @position.x -= 1
    end
    self
  end

  def left
    turn(-1)
  end

  def right
    turn(+1)
  end

  def turn(value)
    @direction_index += value
    reset_direction?
    @direction = DIRECTIONS.key(@direction_index).to_str_up
  end

  # Reset index if out of bounds
  def reset_direction?
    case @direction_index
      when -1
        @direction_index = 3
      when 4
        @direction_index = 0
    end
  end

end