module GameOfLife

  class Cell
    attr_accessor :position, :state, :neighbor_coordinates

    def initialize(coordinates)
      @position = coordinates
      @state = :live
      @neighbor_coordinates = calculate_neighbor_coordinates
    end

    def alive?
      @state == :live
    end

    def calculate_neighbor_coordinates
      offset.reduce([]) do |new_arr, coord|
        new_arr << [coord[0] + @position[0], coord[1] + @position[1]]
      end
    end

    private

    def offset
      offset_range = (-1..1).to_a
      offset_range.product(offset_range).delete_if { |pair| pair == [0,0] }
    end

  end

end
