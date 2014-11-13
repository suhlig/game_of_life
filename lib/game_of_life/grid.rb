module GameOfLife

class Grid
    attr_accessor :cells

    def initialize(pattern: nil, coordinates: nil)
      if pattern
        @cells = build_cells_from_pattern(pattern)
      elsif coordinates.any?
        @cells = build_cells_from_coordinates(coordinates)
      end
    end

    def build_cells_from_coordinates(arr)
      arr = [arr] unless arr.first.is_a?(Array)
      arr.map { |coords| Cell.new(coords) }
    end

    def build_cells_from_pattern(pattern)
      coordinates = []
      pattern.lines.each.with_index(0) do |line, line_index|
        line.each_char.with_index(0) do |char, char_index|
          if char == 'X'
            x_pos = char_index
            y_pos = line_index
            coordinates.push([x_pos, y_pos])
          end
        end
      end
      build_cells_from_coordinates(coordinates)
    end

    def find_living_coordinates
      cells.find_all { |cell| cell.alive? }.map(&:position)
    end
  end

end
