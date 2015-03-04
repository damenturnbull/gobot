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
			when :north.to_s.upcase
				@y += 1
			when :east.to_s.upcase
				@x += 1
			when :south.to_s.upcase
				@y -= 1
			when :west.to_s.upcase
				@x -= 1
		end
	end
end