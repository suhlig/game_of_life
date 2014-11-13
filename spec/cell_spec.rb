require 'spec_helper'

module GameOfLife
  describe Cell do

    before(:each) do
      @cell = Cell.new([1,1])
    end

    it "should respond with a position of 1,1" do
      expect(@cell.position).to eq [1,1]
    end

    it "should be alive as a default" do
      expect(@cell.state).to eq :live
    end
  end
end

