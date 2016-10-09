module TicTacToe
  class Board
  	attr_reader :grid

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end

    def get_cell(x, y)
  		grid[y][x]
		end

		def set_cell(x, y, value)
  		get_cell(x, y).value = value
		end

		def game_over
			return :winner if winner?
			return :draw if draw?
    end

    
    private
 
    def default_grid
      Array.new(3) { Array.new(3) { Cell.new } }  #[[Cell.new]*3]*3
    end

    def draw?
      grid.flatten.map {|cell| cell.value}.none_empty?
    end

    def winning_positions
      grid +
      grid.transpose +
      diagonals
    end

    def diagonals
      [
        [get_cell(0,0), get_cell(1,1), get_cell(2,2)],
        [get_cell(0,2), get_cell(1,1), get_cell(2,0)]
      ]
    end
    
  end
end