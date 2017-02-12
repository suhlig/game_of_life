# frozen_string_literal: true
require 'spec_helper'

module GameOfLife
  describe Cell do
    subject(:cell) { Cell.new(position) }
    let(:position) { [1, 1] }

    it 'should reveal its position' do
      expect(cell.position).to eq([1, 1])
    end

    it 'should be in live state as a default' do
      expect(cell.state).to eq(:live)
    end

    it 'should respond to alive when it is alive' do
      expect(cell.alive?).to be_truthy
    end

    it 'should calculate the coordinates of its 8 neighbors properly' do
      neighbors = [[0, 0], [0, 1], [0, 2],
                   [1, 0],         [1, 2],
                   [2, 0], [2, 1], [2, 2]]

      expect(cell.neighbor_coordinates).to eq(neighbors)
    end
  end
end
