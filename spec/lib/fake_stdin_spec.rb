describe FakeStdin do
  let(:fakestdin) { FakeStdin.new }
  describe 'initialize' do
    it 'creates empty array' do
      expect(fakestdin.inputs).to eq []
    end
  end

  describe '#read' do
    let(:command) { "PLACE 0,0,NORTH" }
    it 'adds command "PLACE 0,0,NORTH" to the input queue' do
      fakestdin.read(:command)
      expect(fakestdin.inputs.first).to eq :command
    end
  end

  describe '#gets' do
    let(:command1) { "PLACE 0,0,NORTH" }
    let(:command2) { "MOVE" }
    context 'given commands "PLACE 0,0,NORTH" and "MOVE" added to the input queue ' do
      it 'the next item in the queue is "PLACE 0,0,NORTH"' do
        fakestdin.read(:command1)
        expect(fakestdin.gets).to eq :command1
      end
      it 'the next item in the queue is "MOVE"' do
        fakestdin.read(:command2)
        expect(fakestdin.gets).to eq :command2
      end
      it 'the next item in the queue is nil' do
        expect(fakestdin.gets).to eq nil
      end
    end
  end
end