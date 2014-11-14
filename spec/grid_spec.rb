require 'spec_helper'

module GameOfLife
  describe Grid do

    before(:all) do
      @cross_pattern = %q(----X----
                          ----X----
                          ----X----
                          ---------
                          XXX---XXX
                          ---------
                          ----X----
                          ----X----
                          ----X----).gsub(/[^\S\n]/m, '')
    end

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
        it "should create a cell with a position of 0,0" do
          expect(@grid.cells.first.position).to eq @coord1
        end

        it "should create a cell with a position of 1,1" do
          expect(@grid.cells[1].position).to eq @coord2
        end
      end

      describe "#live_cells" do

        before(:each) do
          @cell1 = @grid.cells.first
          @cell2 = @grid.cells[1]
        end

        it "should find living cells" do
          expect(@grid.live_cells).to eq [@cell1, @cell2]
        end

        it "should not find dead cells" do
          @cell2.state = :dead
          expect(@grid.live_cells).to eq [@cell1]
        end

      end

      describe "#live_cell_neighbors" do
        it "should find the neighbors of live cells when 1 cell is live" do
          grid = Grid.new(coordinates: [1,1])
          neighbors = [[0,0], [0,1], [0,2],
                       [1,0], [1,2],
                       [2,0], [2,1], [2,2]]
          expect(grid.live_cell_neighbors).to eq neighbors
        end

        it "should find the neighbors of live cells when 2 cells are live" do
          neighbors = [[-1,-1],[-1,0],[-1,1],
                       [0,-1],[0,1],
                       [1,-1],[1,0],[1,1],
                       [0,0], [0,1], [0,2],
                       [1,0], [1,2],
                       [2,0], [2,1], [2,2]]
            expect(@grid.live_cell_neighbors). to eq neighbors
        end
      end

      describe "#cell_scores" do

        it "should produce a score of 1 for the coordinate [2,1]" do
          expect(@grid.cell_scores([2,1])).to eq 1
        end

        it "should produce a score of 1 for the coordinate [1,1]" do
          expect(@grid.cell_scores([1,1])).to eq 1
        end

        it "should produce a score of 2 for the coordinate [1,0]" do
          expect(@grid.cell_scores([1,0])).to eq 2
        end

        it "should produce a score of 4 for the middle of a 3x3 circle" do
          pattern = %q(-X-
                       X-X
                       -X-).gsub(/[^\S\n]/m, '')
          grid = Grid.new(pattern: pattern)
          expect(grid.cell_scores([1,1])).to eq 4
        end

      end

    end

    context "Grid can be initialized using a pattern" do
      before(:each) do
        @grid = GameOfLife::Grid.new(pattern: @cross_pattern)
      end

      it "should have 12 cells" do
        expect(@grid.cells.count).to eq 12
      end

      it "should have a position of [4, 0] for the first cell" do
        expect(@grid.cells.first.position).to eq [4, 0]
      end
    end

  end
end
