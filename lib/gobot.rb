require_relative '../lib/robot'

class Gobot
  # TODO abstract [0-4],[0-4] to correspond with tabletop size
  VALID_COMMANDS    = /^PLACE [0-4],[0-4],(NORTH|EAST|SOUTH|WEST)$|^MOVE$|^LEFT$|^RIGHT$|^REPORT$/
  MESSAGE_ERROR     = "Invalid command. Please try again."
  MESSAGE_OFFLIMITS = "Robot must be placed within the limits of the Tabletop."
  MESSAGE_UNPLACED  = "Robot must be placed first."
  attr_reader   :robot, :tablegrid

  def initialize(tablegrid)
    @tablegrid = tablegrid
    @robot = Robot.new
  end

  # Starter
  def start
    begin
      # Loop through input
      while line = gets
        begin
          validate_command(line)
        rescue ArgumentError => e
          puts e.message
        end
      end
    # Handles signal termination Exceptions
    rescue StandardError => e
      raise e
    # Handles top level Exceptions
    rescue Exception => e
      puts e.message
      puts "\nGobot has gone to sleep. Good bye."
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
    # MOVE|LEFT|RIGHT|REPORT
    pre_move(command)
  end

  #
  def pre_place(command)
    command.slice!(/PLACE /)
    # X,Y,FACING
    bits      = command.split(',')
    x, y      = bits[0].to_i, bits[1].to_i
    direction = bits[2]
    # TODO Check movement within constraints of tablegrid
    @robot.place(Position.new(x,y), direction)
  end

  # Check Robot has been placed first
  def pre_move(command)
    raise ArgumentError, MESSAGE_UNPLACED unless robot.placed
    # TODO Check movement within constraints of tablegrid
    robot.send(command.downcase.to_sym)
  end

end