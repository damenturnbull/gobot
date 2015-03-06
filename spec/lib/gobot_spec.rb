describe Gobot do

  describe '#initialize' do
  end

  # TODO refactor with more concise pattern
  describe '#validate_command' do
    let(:gobot) { Gobot.new }
    it 'allows PLACE 0,0,NORTH' do
      expect{gobot.validate_command("PLACE 0,0,NORTH")}.to_not raise_error
    end
    it 'allows MOVE' do
      expect{gobot.validate_command("move")}.to_not raise_error
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
      expect(gobot.validate_command("DERP")).to eq(Gobot::COMMAND_ERROR)
    end
    it 'disallows PLACE1,1,NORTH' do
      expect(gobot.validate_command("PLACE1,1,NORTH")).to eq(Gobot::COMMAND_ERROR)
    end
    it 'disallows PLACE1,1' do
      expect(gobot.validate_command("PLACE1,1")).to eq(Gobot::COMMAND_ERROR)
    end
    it 'disallows PLACE NORTH' do
      expect(gobot.validate_command("PLACE NORTH")).to eq(Gobot::COMMAND_ERROR)
    end
    it 'disallows PLACE -1,-1,NORTH' do
      expect(gobot.validate_command("PLACE -1,-1,NORTH")).to eq(Gobot::COMMAND_ERROR)
    end
    it 'disallows PLACE 5,5,NORTH' do
      expect(gobot.validate_command("PLACE 5,5,NORTH")).to eq(Gobot::COMMAND_ERROR)
    end
  end

end