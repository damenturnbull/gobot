class Robot
  attr_reader :position, :direction, :placed

  def initialize
    @directions = [:north, :east, :south, :west]
    @placed     = false
  end

  def place(position, direction)
    @position   = position
    @direction  = direction.to_sym.downcase
    @placed     = true
    # Set initial directions pointer
    @directions.rotate! until @directions.first == @direction
    self
  end

  def move
    case @direction
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

  def turn(value)
    @direction = @directions.rotate!(value).first
  end

  def left
    turn -1
  end

  def right
    turn +1
  end

  def to_s
    raise ArgumentError, MESSAGE_UNPLACED unless @placed
    "#{@position.x},#{@position.y},#{@direction.upcase}\n"
  end

end