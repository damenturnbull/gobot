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
    # TODO check out of bounds placements
    let(:position)  { Position.new(0,0) }
    let(:robot)     { Robot.new.place(:position, "NORTH") }
    it 'sets direction' do
      expect(robot.direction).to eq(:north)
    end
    it 'sets position' do
      expect(robot.position).to eq :position
    end
  end

  describe '#move' do
    it 'advances the robot NORTH' do
      robot = Robot.new.place(Position.new(0,0), "NORTH").move
      expect(robot.position.y).to eq(1)
    end
    it 'advances the robot EAST' do
      robot = Robot.new.place(Position.new(0,0), "EAST").move
      expect(robot.position.x).to eq(1)
    end
    it 'advances the robot SOUTH' do
      robot = Robot.new.place(Position.new(0,0), "SOUTH").move
      expect(robot.position.y).to eq(-1)
    end
    it 'advances the robot WEST' do
      robot = Robot.new.place(Position.new(0,0), "WEST").move
      expect(robot.position.x).to eq(-1)
    end
  end

  describe '#turn' do
    context 'when Robot is facing NORTH and turns left' do
      let(:robot) { Robot.new.place(Position.new(0,0), "NORTH") }
      it 'Robot is facing WEST' do
        robot.turn -1
        expect(robot.direction).to eq(:west)
      end
    end
    context 'when Robot is facing WEST and turns right' do
      let(:robot) { Robot.new.place(Position.new(0,0), "WEST") }
      it 'Robot is facing NORTH' do
        robot.turn 1
        expect(robot.direction).to eq(:north)
      end
    end
  end

  describe '#left' do
    context 'when Robot is facing EAST and turns left' do
      let(:robot) { Robot.new.place(Position.new(0,0), "EAST") }
      it 'Robot is facing NORTH' do
        robot.left
        expect(robot.direction).to eq(:north)
      end
    end
    context 'when Robot is facing NORTH and turns left' do
      let(:robot) { Robot.new.place(Position.new(0,0), "NORTH") }
      it 'Robot is facing WEST' do
        robot.left
        expect(robot.direction).to eq(:west)
      end
    end
  end

  describe '#right' do
    context 'when Robot is facing WEST and turns right' do
      let(:robot) { Robot.new.place(Position.new(0,0), "WEST") }
      it 'Robot is facing NORTH' do
        robot.right
        expect(robot.direction).to eq(:north)
      end
    end
    context 'when Robot is facing NORTH and turns right' do
      let(:robot) { Robot.new.place(Position.new(0,0), "NORTH") }
      it 'Robot is facing EAST' do
        robot.right
        expect(robot.direction).to eq(:east)
      end
    end
  end


  # describe '#report' do
  #   let(:gobot) { Gobot.new(TableGrid.new(5,5)) }
  #   context 'when Robot has not been placed' do
  #     it 'raises ArgumentError' do
  #       expect { gobot.report }.to raise_error(ArgumentError)
  #     end
  #   end
  #   context 'when Robot has been placed at NORTH 0,0' do
  #     it 'reports "Robot is currently at NORTH 0,0"' do
  #       gobot.robot.place(Position.new(0,0), "NORTH")
  #       expect(gobot.report).to eq("Robot is currently at NORTH 0,0")
  #     end
  #   end
  # end

end








