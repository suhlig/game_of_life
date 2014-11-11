require "game_of_life/version"

module GameOfLife

  class Grid
    attr_accessor :cells
    def initialize(*arr)
      @cells = arr.map { |coords| Cell.new(coords) }
    end
  end

  class Cell
    attr_accessor :position, :state

    def initialize(coordinates)
      @position = coordinates
      @state = :live
    end
  end

end
