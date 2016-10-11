module TicTacToe
	class Game
		attr_reader :players, :board, :current_player, :other_player

		def initialize (players, board = Board.new)
			@players = players
			@board = board
			@current_player, @other_player = players.shuffle
		end

		def switch_players
			@current_player, @other_player = @other_player, @current_player
		end

		def welcome_message
			"Welcome to Tic Tac Toe"
		end


		def solicit_move
			"#{current_player.name}: Enter a number between 1 and 9 to make your move or enter 'quit' to close the program"
		end

		def get_move(human_move = gets.chomp)
			@human_move = human_move
			human_move_to_coordinate(human_move)
		end

		def check_if_quit
			exit if @human_move.to_s.downcase == "quit"
		end

		def valid_input
			@human_move.to_i.between?(1,9) && @human_move != "/n"
		end

		def game_over_message
			return "#{current_player.name} won!" if board.game_over == :winner
			return "The game ended in a tie" if board.game_over == :draw
		end

		def play_again
			puts "do you wanna play again?"
			input = gets.chomp
			if input.downcase== "yes"
				g = Game.new #you gotta change initialize method to make it work
				g.play
			else
				exit
			end
		end

		def play
			puts "#{current_player.name} has been randomly selected as the first player"
			while true
				puts welcome_message
				board.formatted_grid
				puts ""
				puts solicit_move
				x, y = get_move
				check_if_quit
				until valid_input
					puts solicit_move
					x, y = get_move
					check_if_quit
				end
				if board.not_taken(x, y)
					board.set_cell(x,y, current_player.color)
				else
					puts "I'm sorry #{current_player.name}, but this cell has already been taken. Choose another one"
					x,y = get_move
					board.set_cell(x,y, current_player.color)
				end
				if board.game_over
					puts game_over_message
					board.formatted_grid
					play_again
					#return
				else
					switch_players
				end
			end
		end

		private

		def human_move_to_coordinate(human_move)
			mapping = {
				"1" => [0,0],
				"2" => [1,0],
				"3" => [2,0],
				"4" => [0,1],
				"5" => [1,1],
				"6" => [2,1],
				"7" => [0,2],
				"8" => [1,2],
				"9" => [2,2]
			}
			mapping[human_move]
		end


	end
end