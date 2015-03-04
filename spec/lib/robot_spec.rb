describe Robot do 

	describe '#initialize' do
		let(:robot) { Robot.new("NORTH", 0, 0) }
		it 'creates object' do
			expect(robot).not_to be nil
		end
		it 'sets direction' do
			expect(robot.direction).to eq("NORTH")
		end
		it 'sets x' do
			expect(robot.x).to eq(0)
		end
		it 'sets y' do
			expect(robot.y).to eq(0)
		end
		it 'sets placed to false' do
			expect(robot.placed).to be false
		end
	end

	describe '#move_forward' do
		it 'advances the robot North' do
			robot = Robot.new("NORTH", 0,0)
			robot.move_forward
			expect(robot.y).to eq(1)
		end
		it 'advances the robot East' do
			robot = Robot.new("EAST", 0,0)
			robot.move_forward
			expect(robot.x).to eq(1)
		end
		it 'advances the robot South' do
			robot = Robot.new("SOUTH", 0,0)
			robot.move_forward
			expect(robot.y).to eq(-1)
		end
		it 'advances the robot West' do
			robot = Robot.new("WEST", 0,0)
			robot.move_forward
			expect(robot.x).to eq(-1)
		end
	end

end