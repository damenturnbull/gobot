class Robot
  attr_accessor :direction, :x, :y, :placed
  attr_reader   :direction_index
  Directions = {:north => 0, :east => 1, :south => 2, :west => 3}

  def initialize(direction, x, y)
    @direction        = direction
    @direction_index  = Directions[@direction.to_sym.downcase]
    @x                = x
    @y                = y
    @placed           = false
  end

  def move_forward
    case @direction.to_sym.downcase
      when :north
        @y += 1
      when :east
        @x += 1
      when :south
        @y -= 1
      when :west
        @x -= 1
    end
  end

  def turn_left
    turn(-1)
  end

  def turn_right
    turn(+1)
  end

  def turn(value)
    @direction_index += value
    validate_direction
    @direction = Directions.key(@direction_index).to_s.upcase
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

  # def to_sym_down
  # end

  # def to_str_up
  # end
end