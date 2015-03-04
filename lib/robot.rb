class Robot
	attr_accessor :direction, :x, :y, :placed

	def initialize(direction, x, y)
		@direction	= direction
		@x					= x
		@y					= y
		@placed			= false
	end

	def move_forward
		case @direction
			when "NORTH"
				@y += 1
			when "EAST"
				@x += 1
			when "SOUTH"
				@y -= 1
			when "WEST"
				@x -= 1
		end
	end
end