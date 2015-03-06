require_relative '../lib/robot'

class Gobot
  # TODO abstract [0-4],[0-4] to correspond with tabletop size
  COMMAND_PLACE = /PLACE [0-4],[0-4],(NORTH|EAST|SOUTH|WEST)/
  COMMAND_MOVES = /MOVE|LEFT|RIGHT/
  COMMAND_UTILS = /REPORT/
  MESSAGE_ERROR = "Invalid command. Please try again."
  MESSAGE_UNPLACED = "Robot must be placed first."
  attr_reader   :robot, :tablegrid

  def initialize(tablegrid)
    @tablegrid = tablegrid
    @robot = Robot.new
    self
  end

  # Asks for input
  # Handles top level and Signal terminations Exceptions
  def start
    begin
      while line = gets
        validate_command(line)
      end
    rescue ArgumentError => e
      puts e.message
    rescue StandardError => e
      raise e
    rescue Exception => e
      puts "\nGobot is asleep. Good bye."
    end
  end

  # Handles invalid command Exceptions
  def validate_command(command)
    command = command.strip.upcase
    valid = COMMAND_MOVES =~ command || COMMAND_PLACE =~ command || COMMAND_UTILS =~ command
    raise ArgumentError, MESSAGE_ERROR unless valid
    handle_command(command)
  end

  def handle_command(command)
    case command
    when COMMAND_PLACE =~ command
      # puts "Command is #{command}"
      pre_place(command)
    when COMMAND_MOVES =~ command
      pre_move(command)
    when COMMAND_UTILS =~ command
      report
    end
  end

  # Check if movement valid
  def pre_place(command)
    command.slice!(/PLACE /)
    bits      = command.split(',')
    x         = bits[0].to_i
    y         = bits[1].to_i
    direction = bits[2]
    @robot.place(Position.new(x,y), direction)
  end

  # Check Robot has been placed first
  def pre_move(command)
    raise ArgumentError, MESSAGE_UNPLACED unless robot.placed
    robot.send(command.downcase.to_sym)
  end

  def report
    puts "2 here"
    raise ArgumentError, MESSAGE_UNPLACED unless robot.placed
    "Robot is currently at #{robot.direction} #{robot.position.x},#{robot.position.y}"
  end

end