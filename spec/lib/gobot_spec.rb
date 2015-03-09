describe Gobot do

  before do
    @stdin   = FakeStdin.new
    @stdout  = StringIO.new
  end

  #--------------------------------------------
  # Roaming tests
  #--------------------------------------------
  describe '#start' do
    # Placement
    context 'Placement: given a tabletop of dimension 5 x 5' do
      let(:gobot) { Gobot.new(TableGrid.new(5,5), @stdin, @stdout) }

      # Placement > valid
      context 'when placement is valid' do

        context 'given PLACE 0,0,NORTH then REPORT' do
          before do
            @stdin.read "PLACE 0,0,NORTH"
            @stdin.read "REPORT"
            gobot.start
          end
          it 'Reports: 0,0,NORTH' do
            expect(@stdout.string.chomp).to eq "0,0,NORTH"
          end
        end

        context 'given PLACE 0,0,NORTH then PLACE 4,4,SOUTH then REPORT' do
          before do
            @stdin.read "PLACE 0,0,NORTH"
            @stdin.read "PLACE 4,4,SOUTH"
            @stdin.read "REPORT"
            gobot.start
          end
          it 'Reports: 4,4,SOUTH' do
            expect(@stdout.string.chomp).to eq "4,4,SOUTH"
          end
        end
      end

      # Placement > invalid
      context 'when placement is invalid' do

        context 'given MOVE' do
          before do
            @stdin.read "MOVE"
            gobot.start
          end
          it "Raises: #{MessageUnplaced}" do
            expect(@stdout.string.chomp).to eq MessageUnplaced
          end
        end

        context 'given PLACE 5,5,NORTH' do
          before do
            @stdin.read "PLACE 5,5,NORTH"
            gobot.start
          end
          it "Raises: #{MessageOffLimits}" do
            expect(@stdout.string.chomp).to eq MessageOffLimits
          end
        end

        context 'given PLACE -1,-1,NORTH' do
          before do
            @stdin.read "PLACE -1,-1,NORTH"
            gobot.start
          end
          it "Raises: #{MessageOffLimits}" do
            expect(@stdout.string.chomp).to eq MessageOffLimits
          end
        end
      end
    end

    # Movement
    context 'Movement: given a tabletop of dimension 5 x 5' do
      let(:gobot) { Gobot.new(TableGrid.new(5,5), @stdin, @stdout) }

      # Movement > valid
      context 'when movement is valid' do

        context 'given PLACE 0,0,NORTH then MOVE then REPORT' do
          before do
            @stdin.read "PLACE 0,0,NORTH"
            @stdin.read "MOVE"
            @stdin.read "REPORT"
            gobot.start
          end
          it 'Reports: 0,1,NORTH' do
            expect(@stdout.string.chomp).to eq "0,1,NORTH"
          end
        end

        context 'given PLACE 0,0,EAST then MOVE then REPORT' do
          before do
            @stdin.read "PLACE 0,0,EAST"
            @stdin.read "MOVE"
            @stdin.read "REPORT"
            gobot.start
          end
          it "Reports: 1,0,EAST" do
            expect(@stdout.string.chomp).to eq "1,0,EAST"
          end
        end
      end

      # Movement > invalid
      context 'when movement is invalid' do

        context 'given PLACE 4,4,NORTH then MOVE' do
          before do
            @stdin.read "PLACE 4,4,NORTH"
            @stdin.read "MOVE"
            gobot.start
          end
          it "Raises: #{MessagePrevented}" do
            expect(@stdout.string.chomp).to eq MessagePrevented
          end
        end
      end
    end

    # Rotation
    context 'Rotation: given a tabletop of dimension 5 x 5' do
      let(:gobot) { Gobot.new(TableGrid.new(5,5), @stdin, @stdout) }

      # Rotation > Single
      context 'when single rotation' do

        context 'given PLACE 0,0,NORTH then LEFT then REPORT' do
          before do
            @stdin.read "PLACE 0,0,NORTH"
            @stdin.read "LEFT"
            @stdin.read "REPORT"
            gobot.start
          end
          it 'Reports: 0,0,WEST' do
            expect(@stdout.string.chomp).to eq "0,0,WEST"
          end
        end

        context 'given PLACE 0,0,NORTH then RIGHT then REPORT' do
          before do
            @stdin.read "PLACE 0,0,NORTH"
            @stdin.read "RIGHT"
            @stdin.read "REPORT"
            gobot.start
          end
          it 'Reports: 0,0,EAST' do
            expect(@stdout.string.chomp).to eq "0,0,EAST"
          end
        end
      end

      # Rotation > Multiple in one direction
      context 'when multiple rotations in one direction' do

        context 'given PLACE 0,0,NORTH then LEFT then LEFT then REPORT' do
          before do
            @stdin.read "PLACE 0,0,NORTH"
            @stdin.read "LEFT"
            @stdin.read "LEFT"
            @stdin.read "REPORT"
            gobot.start
          end
          it 'Reports: 0,0,SOUTH' do
            expect(@stdout.string.chomp).to eq "0,0,SOUTH"
          end
        end

        context 'given PLACE 0,0,NORTH then RIGHT then RIGHT then REPORT' do
          before do
            @stdin.read "PLACE 0,0,NORTH"
            @stdin.read "RIGHT"
            @stdin.read "RIGHT"
            @stdin.read "REPORT"
            gobot.start
          end
          it 'Reports: 0,0,SOUTH' do
            expect(@stdout.string.chomp).to eq "0,0,SOUTH"
          end
        end
      end

      # Rotation > each direction
      context 'when rotation in one direction then the other' do

        context 'given PLACE 0,0,NORTH then LEFT then RIGHT then REPORT' do
          before do
            @stdin.read "PLACE 0,0,NORTH"
            @stdin.read "LEFT"
            @stdin.read "RIGHT"
            @stdin.read "REPORT"
            gobot.start
          end
          it 'Reports: 0,0,NORTH' do
            expect(@stdout.string.chomp).to eq "0,0,NORTH"
          end
        end

        context 'given PLACE 0,0,NORTH then RIGHT then LEFT then REPORT' do
          before do
            @stdin.read "PLACE 0,0,NORTH"
            @stdin.read "RIGHT"
            @stdin.read "LEFT"
            @stdin.read "REPORT"
            gobot.start
          end
          it 'Reports: 0,0,SOUTH' do
            expect(@stdout.string.chomp).to eq "0,0,NORTH"
          end
        end
      end
    end

    # Placement, Movement and Rotation
    context 'Placement, Movement and Rotation: given a tabletop of dimension 5 x 5' do
      let(:gobot) { Gobot.new(TableGrid.new(5,5), @stdin, @stdout) }

      context 'given PLACE 1,2,EAST then MOVE then MOVE then LEFT then MOVE then REPORT' do
        before do
          @stdin.read "PLACE 1,2,EAST"
          @stdin.read "MOVE"
          @stdin.read "MOVE"
          @stdin.read "LEFT"
          @stdin.read "MOVE"
          @stdin.read "REPORT"
          gobot.start
        end
        it 'Reports: 3,3,NORTH' do
          expect(@stdout.string.chomp).to eq "3,3,NORTH"
        end
      end
    end
  end


  #--------------------------------------------
  # UNIT tests
  #--------------------------------------------
  describe '#initialize' do
    subject { Gobot.new(TableGrid.new(5,5)).tablegrid }
    it { is_expected.not_to be nil }
  end

  describe '#validate_command' do
    let(:gobot) { Gobot.new(TableGrid.new(5,5)) }

    it 'disallows PLACE0,0,NORTH' do
      expect{gobot.validate_command("PLACE0,0,NORTH")}.to raise_error
    end

    it 'disallows MOVE1' do
      expect{gobot.validate_command("MOVE1")}.to raise_error
    end

    it 'disallows LEF' do
      expect{gobot.validate_command("LEF")}.to raise_error
    end

    it 'disallows DERP' do
      expect{gobot.validate_command("DERP")}.to raise_error
    end
  end

  describe '#parse_command' do
    subject(:gobot) { Gobot.new(TableGrid.new(5,5)) }

    context 'when Robot has not been placed' do
      it 'raises error' do
        expect { gobot.parse_command "MOVE" }.to raise_error
      end
    end

    context 'when Robot has been placed' do
      before { gobot.robot.place(Position.new(0,0), "NORTH") }
      it 'does not raise error' do
        expect { gobot.parse_command "MOVE" }.to_not raise_error
      end

      it 'given argument "PLACE 0,0,NORTH" it calls the handle_place method' do
        expect(gobot).to receive(:handle_place)
        gobot.parse_command "PLACE 0,0,NORTH"
      end

      it 'given argument "MOVE" it calls the handle_move method' do
        expect(gobot).to receive(:handle_move)
        gobot.parse_command "MOVE"
      end

      it 'given argument "LEFT" it calls the handle_left method' do
        expect(gobot).to receive(:handle_left)
        gobot.parse_command "LEFT"
      end

      it 'given argument "RIGHT" it calls the handle_right method' do
        expect(gobot).to receive(:handle_right)
        gobot.parse_command "RIGHT"
      end

      it 'given argument "REPORT" it calls the handle_report method' do
        expect(gobot).to receive(:handle_report)
        gobot.parse_command "REPORT"
      end
    end
  end

  # Given
  describe '#handle_place' do
    let(:gobot) { Gobot.new(TableGrid.new(5,5)) }

    context 'when placed within limits of tabletop' do
      it 'does not raise error' do
        expect { gobot.handle_place("PLACE 4,4,NORTH") }.not_to raise_error
      end
    end

    context 'when placed beyond limits of tabletop' do
      it 'raises error' do
        expect { gobot.handle_place("PLACE 5,5,NORTH") }.to raise_error
      end
    end
  end

  describe '#handle_move' do
    let(:gobot) { Gobot.new(TableGrid.new(5,5)) }
    context 'when Robot on NORTH edge of tabletop' do
      before { gobot.robot.place(Position.new(0,4), "NORTH") }
      it 'moving forward is prevented' do
        expect { gobot.handle_move }.to raise_error
      end
    end

    context 'when Robot on EAST edge of tabletop' do
      before { gobot.robot.place(Position.new(4,4), "EAST") }
      it 'moving forward is prevented' do
        expect { gobot.handle_move }.to raise_error
      end
    end

    context 'when Robot on SOUTH edge of tabletop' do
      before { gobot.robot.place(Position.new(4,0), "SOUTH") }
      it 'moving forward is prevented' do
        expect { gobot.handle_move }.to raise_error
      end
    end

    context 'when Robot on WEST edge of tabletop' do
      before { gobot.robot.place(Position.new(0,0), "WEST") }
      it 'moving forward is prevented' do
        expect { gobot.handle_move }.to raise_error
      end
    end
  end

end