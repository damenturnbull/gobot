describe Position do
  describe 'initialize' do
    let(:position) { Position.new(0,0) }

    it 'given x value of 0 sets x to 0' do
      expect(position.x).to eq 0
    end

    it 'given y value of 0 sets y to 0' do
      expect(position.y).to eq 0
    end
  end
end