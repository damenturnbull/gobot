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
    it 'allows PLACE 0,0,NORTH' do
      expect{gobot.validate_command("PLACE 0,0,NORTH")}.to_not raise_error
    end
    it 'allows MOVE' do
      expect{gobot.validate_command("MOVE")}.to_not raise_error
    end
    it 'allows LEFT' do
      expect{gobot.validate_command("LEFT")}.to_not raise_error
    end
    it 'allows RIGHT' do
      expect{gobot.validate_command("RIGHT")}.to_not raise_error
    end
    it 'allows REPORT' do
      expect{gobot.validate_command("REPORT")}.to_not raise_error
    end
    it 'disallows DERP' do
      expect(gobot.validate_command("DERP")).to eq(Gobot::MESSAGE_ERROR)
    end
    it 'disallows PLACE1,1,NORTH' do
      expect(gobot.validate_command("PLACE1,1,NORTH")).to eq(Gobot::MESSAGE_ERROR)
    end
    it 'disallows PLACE1,1' do
      expect(gobot.validate_command("PLACE1,1")).to eq(Gobot::MESSAGE_ERROR)
    end
    it 'disallows PLACE NORTH' do
      expect(gobot.validate_command("PLACE NORTH")).to eq(Gobot::MESSAGE_ERROR)
    end
    it 'disallows PLACE -1,-1,NORTH' do
      expect(gobot.validate_command("PLACE -1,-1,NORTH")).to eq(Gobot::MESSAGE_ERROR)
    end
    it 'disallows PLACE 5,5,NORTH' do
      expect(gobot.validate_command("PLACE 5,5,NORTH")).to eq(Gobot::MESSAGE_ERROR)
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
        gobot.pre_place("NORTH 0,0")
        expect(gobot.robot.position)  .to_not be nil
        expect(gobot.robot.position.x).to eq(0)
        expect(gobot.robot.position.y).to eq(0)
      end
    end

    # gobot.robot.place("NORTH", Position.new(0,0)
    # it 'disallows PLACE 5,5,NORTH' do
    #   expect(gobot.validate_command("PLACE 5,5,NORTH")).to eq(Gobot::MESSAGE_ERROR)
    # end
  end

  describe '#pre_move' do
    let(:gobot) { Gobot.new(TableGrid.new(5,5)) }
    context 'when Robot has not been placed' do
      it 'raises error' do
        expect { gobot.pre_move("this")   }.to raise_error
      end
    end
    context 'when Robot has been placed' do
      it 'allows valid commands' do
        gobot.robot.place("NORTH", Position.new(0,0))
        expect { gobot.pre_move("MOVE")   }.to_not raise_error
        expect { gobot.pre_move("LEFT")   }.to_not raise_error
        expect { gobot.pre_move("RIGHT")  }.to_not raise_error
      end
      it 'disallows invalid commands' do
        gobot.robot.place("NORTH", Position.new(0,0))
        expect { gobot.pre_move("blah")   }.to raise_error
      end
    end
  end


end