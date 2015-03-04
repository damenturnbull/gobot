class Robot
	attr_accessor :direction, :x, :y, :placed

	def initialize(direction, x, y)
		@direction	= direction
		@x					= x
		@y					= y
		@placed			= false
	end	
end