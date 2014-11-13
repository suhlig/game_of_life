require 'spec_helper'

module GameOfLife
  describe Grid do

    context "Grid is initialized with a single cell" do
      before(:each) do
        live_coordinates = [0, 0]
        @grid = GameOfLife::Grid.new(coordinates: live_coordinates)
      end

      describe "#initialize" do
        it "should have a position of 0, 0" do
          expect(@grid.cells.first.position).to eq [0,0]
        end
      end
    end

    context "Grid is initialized with two cells" do
      before(:each) do
        @coord1 = [0,0]
        @coord2 = [1,1]
        @grid = GameOfLife::Grid.new(coordinates: [@coord1, @coord2])
      end

      describe "#initialize" do
        it "should have a first position of 0,0" do
          expect(@grid.cells.first.position).to eq @coord1
        end

        it "should have a second position of 1,1" do
          expect(@grid.cells[1].position).to eq @coord2
        end
      end
    end

    context "Grid can be initialized using a pattern" do
      before(:each) do
        pattern = %q(----X----
                     ----X----
                     ----X----
                     ---------
                     XXX---XXX
                     ---------
                     ----X----
                     ----X----
                     ----X----).gsub(/[^\S\n]/m, '')
       @grid = GameOfLife::Grid.new(pattern: pattern)
      end

      it "should have 12 cells" do
        expect(@grid.cells.count).to eq 12
      end

      it "should have a position of [4, 0] for the first cell" do
        expect(@grid.cells.first.position).to eq [4, 0]
      end
    end

    describe "#draw" do
      it "draws the grid" do
        skip("Not yet implemented")
      end
    end
  end
end
