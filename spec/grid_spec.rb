require 'spec_helper'

module GameOfLife
  describe Grid do

    context "Grid is initialized with a single cell" do
      before(:each) do
        live_coordinates = [0, 0]
        @grid = GameOfLife::Grid.new(live_coordinates)
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
        @grid = GameOfLife::Grid.new(@coord1, @coord2)
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

    describe "#draw" do
      it "draws the grid" do
        skip("Not yet implemented")
      end
    end
  end
end
