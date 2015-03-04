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
	end

end