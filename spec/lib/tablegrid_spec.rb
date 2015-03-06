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

end