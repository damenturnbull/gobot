# Handle Ctrl+c interruptions
Signal.trap("INT") {
  puts "Robot is sleeping now. Goodbye."
  exit 1
}

require_relative '../lib/robot'
require_relative '../lib/position'

class Gobot
  # TODO abstract [0-4],[0-4] to correspond with tabletop size
  VALID_COMMANDS    = /^PLACE [0-9],[0-9],(NORTH|EAST|SOUTH|WEST)$|^MOVE$|^LEFT$|^RIGHT$|^REPORT$/
  MESSAGE_ERROR     = "Invalid command. Please try again."
  MESSAGE_OFFLIMITS = "Robot must be placed within the limits of the Tabletop."
  MESSAGE_PREVENTED = "Danger: Edge of Tabletop. Robot can't move forward!"
  MESSAGE_UNPLACED  = "Robot must be placed first."
  attr_reader   :robot, :tablegrid

  def initialize(tablegrid)
    @tablegrid = tablegrid
    @robot = Robot.new
  end

  def start
    # Loop through input
    while line = gets
      begin
        validate_command(line)
      rescue Exception => e
        puts e.message
      end
    end
  end

  # Handles invalid command Exceptions
  def validate_command(command)
    command = command.chomp.upcase
    raise ArgumentError, MESSAGE_ERROR unless VALID_COMMANDS =~ command
    handle_command(command)
  end

  def handle_command(command)
    # PLACE
    if /^(PLACE )/ =~ command
      return pre_place(command)
    end
    # Ignore further action unless Robot placed
    is_placed?
    # MOVE
    if /^MOVE$/ =~ command
      return try_move
    end
    # LEFT|RIGHT|REPORT remains...
    @robot.send(command.downcase.to_sym)
  end

  #
  def pre_place(command)
    command.slice!(/PLACE /)
    # X,Y,FACING
    pieces    = command.split(',')
    x, y      = pieces.shift.to_i, pieces.shift.to_i
    direction = pieces.shift
    # TODO Check movement within constraints of tablegrid
    raise ArgumentError, MESSAGE_OFFLIMITS unless tablegrid.within_limits(x, y)
    @robot.place(Position.new(x,y), direction)
  end

  def try_move
    case @robot.direction
    when :north
      move_valid = tablegrid.within_y(@robot.position.y + 1)
      raise ArgumentError, MESSAGE_PREVENTED unless move_valid
    when :east
      move_valid = tablegrid.within_x(@robot.position.x + 1)
      raise ArgumentError, MESSAGE_PREVENTED unless move_valid
    when :south
      move_valid = tablegrid.within_y(@robot.position.y - 1)
      raise ArgumentError, MESSAGE_PREVENTED unless move_valid
    when :west
      move_valid = tablegrid.within_x(@robot.position.x - 1)
      raise ArgumentError, MESSAGE_PREVENTED unless move_valid
    end
    @robot.move
  end

  # Check Robot has been placed first
  def is_placed?
    raise ArgumentError, MESSAGE_UNPLACED unless @robot.placed
  end

end