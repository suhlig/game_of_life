# frozen_string_literal: true
require 'spec_helper'

module GameOfLife
  describe Grid do
    before(:all) do
      @cross_pattern = '----X----
                        ----X----
                        ----X----
                        ---------
                        XXX---XXX
                        ---------
                        ----X----
                        ----X----
                        ----X----'.gsub(/[^\S\n]/m, '')
    end

    context 'Grid is initialized with a single cell' do
      subject(:grid) { GameOfLife::Grid.new(coordinates: live_coordinates) }
      let(:live_coordinates) { [0, 0] }

      describe '#initialize' do
        it 'should have a position of 0, 0' do
          expect(grid.cells.first.position).to eq [0, 0]
        end
      end
    end

    context 'Grid is initialized with two cells' do
      subject(:grid) { GameOfLife::Grid.new(coordinates: [coord1, coord2]) }
      let(:coord1) { [0, 0] }
      let(:coord2) { [1, 1] }

      describe '#initialize' do
        it 'should create a cell with a position of 0,0' do
          expect(grid.cells.first.position).to eq(coord1)
        end

        it 'should create a cell with a position of 1,1' do
          expect(grid.cells[1].position).to eq(coord2)
        end
      end

      describe '#live_cells' do
        let(:cell1) { grid.cells.first }
        let(:cell2) { grid.cells[1] }

        it 'should find living cells' do
          expect(grid.live_cells).to eq([cell1, cell2])
        end

        it 'should not find dead cells' do
          cell2.state = :dead
          expect(grid.live_cells).to eq([cell1])
        end
      end

      describe '#live_cell_neighbors' do
        it 'should find the neighbors of live cells when 1 cell is live' do
          grid = Grid.new(coordinates: [1, 1])

          neighbors = [[0, 0], [0, 1], [0, 2],
                       [1, 0],         [1, 2],
                       [2, 0], [2, 1], [2, 2]]

          expect(grid.live_cell_neighbors).to eq(neighbors)
        end

        it 'should find the neighbors of live cells when 2 cells are live' do
          # rubocop:disable Style/SpaceInsideBrackets
          neighbors = [
            [-1, -1], [-1, 0], [-1, 1],
            [ 0, -1],          [ 0, 1],
            [ 1, -1], [ 1, 0], [ 1, 1],
            [ 0,  0], [ 0, 1], [ 0, 2],
            [ 1,  0],          [ 1, 2],
            [ 2,  0], [ 2, 1], [ 2, 2],
          ]
          # rubocop:enable Style/SpaceInsideBrackets

          expect(grid.live_cell_neighbors). to eq(neighbors)
        end
      end

      describe '#cell_scores' do
        it 'should produce a score of 1 for the coordinate [2,1]' do
          expect(grid.cell_scores([2, 1])).to eq(1)
        end

        it 'should produce a score of 1 for the coordinate [1,1]' do
          expect(grid.cell_scores([1, 1])).to eq(1)
        end

        it 'should produce a score of 2 for the coordinate [1,0]' do
          expect(grid.cell_scores([1, 0])).to eq(2)
        end
      end
    end

    context 'Grid can be initialized using a pattern' do
      subject(:grid) { GameOfLife::Grid.new(pattern: cross_pattern) }

      context 'context' do
        let(:cross_pattern) {
          '----X----
           ----X----
           ----X----
           ---------
           XXX---XXX
           ---------
           ----X----
           ----X----
           ----X----'.gsub(/[^\S\n]/m, '')
        }

        it 'should have 12 cells' do
          expect(grid.cells.count).to eq 12
        end

        it 'should have a position of [4, 0] for the first cell' do
          expect(grid.cells.first.position).to eq [4, 0]
        end
      end

      context 'context' do
        let(:cross_pattern) {
          '-X-
           X-X
           -X-'.gsub(/[^\S\n]/m, '')
        }

        it 'should produce a score of 4 for the middle of a 3x3 circle' do
          expect(grid.cell_scores([1, 1])).to eq(4)
        end
      end
    end
  end
end
