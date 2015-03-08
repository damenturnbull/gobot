describe TableGrid do

  describe '#initialize' do
    let(:tablegrid) { TableGrid.new(5, 5) }
    it 'creates object' do
      expect(tablegrid).not_to be nil
    end
    it 'sets width' do
      expect(tablegrid.width).to eq(5)
    end
    it 'sets height' do
      expect(tablegrid.height).to eq(5)
    end
    it 'sets max x' do
      expect(tablegrid.max_x).to eq(4)
    end
    it 'sets max y' do
      expect(tablegrid.max_y).to eq(4)
    end
  end

  describe '#within_limits' do
    let(:tablegrid) { TableGrid.new(5, 5) }
    context 'when Robot placed within the limits of a 5 x 5 tabletop' do
      it 'allows x:4 and y:0' do
        expect(tablegrid.within_limits(4,0)).to eq true
      end
      it 'allows x:0 and y:4' do
        expect(tablegrid.within_limits(0,4)).to eq true
      end
    end
    context 'when Robot placed beyond the limits of a 5 x 5 tabletop' do
      it 'disallows x:5  and y:0' do
        expect(tablegrid.within_limits(5,0)).to eq false
      end
      it 'disallows x:0  and y:5' do
        expect(tablegrid.within_limits(0,5)).to eq false
      end
      it 'disallows x:-1 and y:0' do
        expect(tablegrid.within_limits(-1,0)).to eq false
      end
      it 'disallows x:0  and y:-1' do
        expect(tablegrid.within_limits(0,-1)).to eq false
      end
    end
  end

  describe '#within_x' do
    let(:tablegrid) { TableGrid.new(5, 5) }
    context 'when x is within limits of tabletop width given a maximum height of 4 and x of 4' do
      it 'x is allowed' do
        expect(tablegrid.within_x(4)).to eq true
      end
    end
    context 'when x is beyond limits of tabletop width given a maximum height of 4 and x of 5' do
      it 'x is not allowed' do
        expect(tablegrid.within_x(5)).to eq false
      end
    end
  end

  describe '#within_y' do
    let(:tablegrid) { TableGrid.new(5, 5) }
    context 'when y is within limits of tabletop height given a maximum height of 4 and y of 4' do
      it 'y is allowed' do
        expect(tablegrid.within_y(4)).to eq true
      end
    end
    context 'when y is beyond limits of tabletop height given a maximum height of 4 and y of 5' do
      it 'y is not allowed' do
        expect(tablegrid.within_y(5)).to eq false
      end
    end
  end

end