# Handle Ctrl+c interruptions
Signal.trap("INT") {
  puts "Robot is sleeping now. Goodbye."
  exit 1
}

require_relative '../lib/robot'
require_relative '../lib/position'
require_relative '../lib/messages'

class Gobot
  ValidCommands = /^PLACE [0-9\-]+,[0-9\-]+,(NORTH|EAST|SOUTH|WEST)$|^MOVE$|^LEFT$|^RIGHT$|^REPORT$/
  attr_reader    :robot, :tablegrid

  def initialize(tablegrid, stdin = STDIN, stdout = STDOUT)
    @tablegrid  = tablegrid
    @robot      = Robot.new
    @stdin      = stdin
    @stdout     = stdout
  end

  # Game runner 
  def start
    # Loop through input
    while line = @stdin.gets
      begin
        validate_command(line)
      rescue Exception => e
        @stdout.puts "#{e.message}\n"
      end
    end
  end

  # Handles invalid command Exceptions
  def validate_command(command)
    command = command.chomp.upcase
    raise MessageError unless ValidCommands =~ command
    parse_command(command)
  end

  def parse_command(command)
    return handle_place(command) if /^(PLACE )/ =~ command
    # Robot must be placed to continue...
    raise MessageUnplaced unless @robot.placed
    send("handle_#{command.downcase.to_sym}")
  end

  def handle_place(command)
    command.slice!(/PLACE /)
    x, y, direction = command.split(',')
    x, y            = x.to_i, y.to_i
    # Deny a placement beyond table limits
    raise MessageOffLimits unless tablegrid.within_limits(x, y)
    @robot.place( Position.new(x, y), direction )
  end

  def handle_move
    case @robot.direction
    when :north
      raise MessagePrevented unless _move_y_valid? +1
    when :east
      raise MessagePrevented unless _move_x_valid? +1
    when :south
      raise MessagePrevented unless _move_y_valid? -1
    when :west
      raise MessagePrevented unless _move_x_valid? -1
    end
    @robot.move
  end

  def handle_left
    @robot.left
  end

  def handle_right
    @robot.right
  end

  def handle_report
    @stdout.puts robot
  end

private

  def _move_y_valid?(value)
    @tablegrid.within_y(@robot.position.y + value)
  end

  def _move_x_valid?(value)
    @tablegrid.within_x(@robot.position.x + value)
  end

end
