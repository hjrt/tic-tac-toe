module TicTacToe
	class Computer<Player

		#http://programmers.stackexchange.com/questions/213559/algorithm-to-create-an-tictactoe-game-ai
		def move(board) #board.grid? or grid?
			move = win_move(board) ||
				block_move(board) ||
				fork_move(board) ||
				block_fork_move(board) ||
				center_move(board) ||
				opposite_corner_move(board) ||
				empty_corner_move(board) ||
				empty_side_move(board)
			end

			def win_move(board)
				return find_two_in_row(board, self.color)
			end

			def block_move(board)
				return find_two_in_row(board, self.opponent_color)
			end

			def find_two_in_row(board, color)
				board.winning_positions.each do |row|
					if board.two_in_row?(row, color)
						return board.get_free_cell(row)
					end
				end
				nil
			end

			def fork_move(board)
				return possible_fork(board, self.color)
			end

			def possible_fork(board, color)
				board.corners.each do |cell|
					if cell.value == color
						taken_cell = cell
						overlapping_rows = board.winning_positions.select{|rows| (rows & [taken_cell]).length > 0}
						overlapping_rows.each do |row|
							if board.one_in_row?(row, color)
								if taken_cell == row.last
									return row.first
								elsif taken_cell == row.first
									return row.last
								end
							end
						end
					end
				end
				nil
			end

			def block_fork_move(board, color)

			end

			def center_move(board)
			end

			def opposite_corner_move(board)
			end

			def empty_corner(board)

			end

			def empty_side(board)
			end

	end
end
