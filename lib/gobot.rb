class Gobot
  COMMANDS      = /PLACE [0-4],[0-4],(NORTH|EAST|SOUTH|WEST)|MOVE|LEFT|RIGHT|REPORT/
  COMMAND_ERROR = "Invalid command. Please try again."
  attr_reader   :robot

  def initialize
    # @robot = Robot.new("NORTH",nil,nil)
    self
  end

  # Ask for input
  def start
    begin
      while line = gets
        puts validate_command line
      end
    rescue StandardError => e
      raise e
    rescue Exception => e
      puts "\nGobot is asleep. Good bye."
    end
  end

  # PLACE X,Y,F
  # MOVE
  # LEFT
  # RIGHT
  # REPORT
  def validate_command(next_command)
    begin
      # return "Successful command"
      raise ArgumentError, COMMAND_ERROR unless COMMANDS =~ next_command.strip.upcase
      # return next_command
    rescue ArgumentError => e
      e.message
    end
  end

end