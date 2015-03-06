class Robot
  DIRECTIONS =  {:north => 0, :east => 1, :south => 2, :west => 3}
  attr_accessor :direction, :position, :placed
  attr_reader   :direction_index

  def initialize
    @placed = false
  end

  def place(direction, position)
    @direction        = direction
    @direction_index  = DIRECTIONS[@direction.to_sym_down]
    @position         = position
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
    validate_direction
    @direction = DIRECTIONS.key(@direction_index).to_str_up
  end

  # Reset index if out of bounds
  def validate_direction
    case @direction_index
      when -1
        @direction_index = 3
      when 4
        @direction_index = 0
    end
  end

end