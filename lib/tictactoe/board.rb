module TicTacToe
  class Board
  	attr_reader :grid

    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end

    def get_cell(x, y)
  	 grid[y][x]
    end

    def not_taken(x, y)
      get_cell(x, y).value.empty?
    end

    def set_cell(x, y, value)
      get_cell(x, y).value = value
    end

    def game_over
      return :winner if winner?
      return :draw if draw?
    end

    def formatted_grid
      grid.each do |row|
        puts row.map {|cell| cell.value.empty? ? "-" : cell.value}.join("|")
      end
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

    def two_in_row?(row, color)
      amount_of_one_color_in_row == 2 && amount_of_free_cells_in_row == 1
    end

    def amount_of_one_color_in_row(row, color)
      row.select {|cell| cell.value == color}.length
    end

    def amount_of_free_cells_in_row(row, color)
      row.select {|cell| cell.value == ""}.length
    end

    def get_free_cell
    end


    def winner?
      winning_positions.each do |winning_position|
        next if winning_position_values(winning_position).all_empty?
        return true if winning_position_values(winning_position).all_same?
      end
      false
    end

    def winning_position_values(winning_position)
      winning_position.map {|cell| cell.value}
    end

  end
end