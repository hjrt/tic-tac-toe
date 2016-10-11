module TicTacToe
	class Game
		attr_reader :players, :board, :current_player, :other_player

		def initialize (board = Board.new)
			@board = board
			#@current_player, @other_player = players.shuffle
		end

		def beginning
			puts "Welcome to TicTacToe"
			puts "You can choose between following options:
			1) human vs human
			2) human vs computer
			3) computer vs computer"
			puts "Enter an option number - 1, 2 or 3"
			choice = check_choice
			if choice == "1"
				puts "Tell me your name. Or your friend's name. Or just a name."
				name = check_name
				puts "Do you wanna play with 'X' or with 'O'?"
				color = check_color
				set_player(name, color)
			elsif choice == "2"
			elsif choice == "3"
			end
		end

		def check_choice
			begin
				choice = gets.chomp
				unless choice.to_i.between?(1,3)
					raise "Not cool. Don't cheat. Enter 1, 2 or 3"
				end
			rescue => e
				puts "#{e}"
				retry
			else
				return choice
			end
		end

		def check_name
			begin
				name = gets.chomp
				if name == "/n"
					raise "Name, you know, with letters and stuff."
				end
			rescue => e
				puts "#{e}"
				retry
			else
				return name
			end
		end

		def check_color
			begin
				color = gets.chomp
				unless color.upcase == "X" || "O"
					raise "No other options, sorry. Just simple X and O."
				end
			rescue => e
				puts "#{e}"
				retry
			else
				return color
			end
		end

		def set_player
		end

		def switch_players
			@current_player, @other_player = @other_player, @current_player
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
			beginning
			puts "#{current_player.name} has been randomly selected as the first player"
			while true
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