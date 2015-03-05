describe Robot do

  describe '#initialize' do
    let(:robot) { Robot.new }
    it 'creates object' do
      expect(robot).not_to be nil
    end
    it 'sets placed to false' do
      expect(robot.placed).to be false
    end
  end

  describe '#place' do
    robot = Robot.new.place("NORTH", Position.new(0,0))
    it 'sets direction' do
      expect(robot.direction).to eq("NORTH")
    end
    it 'sets direction index to 0' do
      expect(robot.direction_index).to eq(0)
    end
    it 'sets position' do
      expect(robot.position).not_to be nil
    end
  end

  describe '#move_forward' do
    it 'advances the robot NORTH' do
      robot = Robot.new.place("NORTH", Position.new(0,0)).move_forward
      expect(robot.position.y).to eq(1)
    end
    it 'advances the robot EAST' do
      robot = Robot.new.place("EAST", Position.new(0,0)).move_forward
      expect(robot.position.x).to eq(1)
    end
    it 'advances the robot SOUTH' do
      robot = Robot.new.place("SOUTH", Position.new(0,0)).move_forward
      expect(robot.position.y).to eq(-1)
    end
    it 'advances the robot WEST' do
      robot = Robot.new.place("WEST", Position.new(0,0)).move_forward
      expect(robot.position.x).to eq(-1)
    end
  end

  describe '#turn_left' do
    let(:robot) { Robot.new.place("NORTH", Position.new(0,0)) }
    it 'faces the Robot WEST' do
      robot.turn_left
      expect(robot.direction).to eq("WEST")
    end

    context 'when Robot is facing NORTH and turns left' do
      let(:robot) { Robot.new.place("NORTH", Position.new(0,0)) }
      it 'facing WEST' do
        robot.turn_left
        expect(robot.direction).to eq("WEST")
      end
    end
  end

  describe '#turn_right' do
    let(:robot) { Robot.new.place("NORTH", Position.new(0,0)) }
    it 'faces the Robot EAST' do
      robot.turn_right
      expect(robot.direction).to eq("EAST")
    end
    context 'when Robot is facing WEST and turns right' do
      let(:robot) { Robot.new.place("WEST", Position.new(0,0)) }
      it 'facing NORTH' do
        robot.turn_right
        expect(robot.direction).to eq("NORTH")
      end
    end
  end

end








