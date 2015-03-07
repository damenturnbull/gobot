describe Gobot do

  describe '#initialize' do
    subject { Gobot.new(TableGrid.new(5,5)).tablegrid }
    it {
        is_expected.not_to be nil
    }
  end

  # TODO refactor with more concise pattern
  describe '#validate_command' do
    let(:gobot) { Gobot.new(TableGrid.new(5,5)) }
    it 'disallows PLACE0,0,NORTH' do
      expect{gobot.validate_command("PLACE0,0,NORTH")}.to raise_error(ArgumentError)
    end
    it 'disallows MOVE1' do
      expect{gobot.validate_command("MOVE1")}.to raise_error(ArgumentError)
    end
    it 'disallows LEF' do
      expect{gobot.validate_command("LEF")}.to raise_error(ArgumentError)
    end
    it 'disallows DERP' do
      expect{gobot.validate_command("DERP")}.to raise_error(ArgumentError)
    end
  end

  # TODO how to test if a command is returned
  describe '#handle_command' do
  end

  # Given
  describe '#pre_place' do
    let(:gobot) { Gobot.new(TableGrid.new(5,5)) }
    context 'when valid command given' do
      it 'Robot position set correctly' do
        gobot.pre_place("PLACE 0,0,NORTH")
        expect(gobot.robot.position)  .to_not be nil
        expect(gobot.robot.position.x).to eq(0)
        expect(gobot.robot.position.y).to eq(0)
      end
    end
  end

  describe '#pre_move' do
    let(:gobot) { Gobot.new(TableGrid.new(5,5)) }
    context 'when Robot has not been placed' do
      it 'raises error' do
        expect { gobot.pre_move("blah")   }.to raise_error(ArgumentError)
      end
    end
    context 'when Robot has been placed' do
      it 'allows valid commands' do
        gobot.robot.place(Position.new(0,0), "NORTH")
        expect { gobot.pre_move("MOVE")   }.to_not raise_error
        expect { gobot.pre_move("LEFT")   }.to_not raise_error
        expect { gobot.pre_move("RIGHT")  }.to_not raise_error
      end
      it 'disallows invalid commands' do
        gobot.robot.place(Position.new(0,0), "NORTH")
        expect { gobot.pre_move("blah")   }.to raise_error(NoMethodError)
      end
    end
  end

end