class Gobot
  COMMAND_ERROR = "Invalid command. Please try again."
  COMMANDS      = [:place, :move, :left, :right, :report]
  attr_reader   :robot

  def initialize
    # @robot = Robot.new("NORTH",nil,nil)
    self
  end

  # Ask for input
  def start
    begin
      while line = gets
        validate_command line
      end
    rescue StandardError => e
      raise e
    rescue Exception => e
      puts "\nGobot is sleeping now. Good bye."
    end
  end

  # PLACE X,Y,F
  # MOVE
  # LEFT
  # RIGHT
  # REPORT
  def validate_command(command)
    begin
      command = command.strip.to_sym.downcase
      raise ArgumentError, COMMAND_ERROR unless COMMANDS.include? command
      return command
    rescue ArgumentError => e
      puts e.message
    end
  end

end