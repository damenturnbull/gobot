describe Gobot do

  describe '#initialize' do
  end

  describe '#validate_command' do
    let(:gobot) { Gobot.new }
    it 'allows PLACE' do
      expect(gobot.validate_command("PLACE")).to eq(:place)
    end
    it 'allows MOVE' do
      expect(gobot.validate_command("MOVE")).to eq(:move)
    end
    it 'allows LEFT' do
      expect(gobot.validate_command("LEFT")).to eq(:left)
    end
    it 'allows RIGHT' do
      expect(gobot.validate_command("RIGHT")).to eq(:right)
    end
    it 'allows REPORT' do
      expect(gobot.validate_command("REPORT")).to eq(:report)
    end
    it 'allows report in lowercase' do
      expect(gobot.validate_command("REPORT")).to eq(:report)
    end
  end

end