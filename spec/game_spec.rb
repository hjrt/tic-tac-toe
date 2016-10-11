require "spec_helper"

module TicTacToe
	describe Game do
		let (:bob) {Player.new({color: "X", name: "bob"})}
		let (:frank) {Player.new({color: "O", name: "frank"})}

		context "#initialize" do
			it "randomly selects a current player" do
				allow_any_instance_of(Array).to receive(:shuffle) {[frank,bob]}
				game = Game.new([bob, frank])
				expect(game.current_player).to eq frank
			end

			it "randomly selects an other player" do
				allow_any_instance_of(Array).to receive(:shuffle) {[frank, bob]}
				game = Game.new([bob, frank])
				expect(game.other_player).to eq bob
			end
		end

		context "#switch_players" do
			it "will set @current_player to @other_player" do
				game = Game.new([bob, frank])
				other_player = game.other_player
				game.switch_players
				expect(game.current_player).to eq other_player
			end

			it "will set @other_player to @current_player" do
				game = Game.new([bob, frank])
				current_player = game.current_player
				game.switch_players
				expect(game.other_player).to eq current_player
			end
		end

		context "#welcome_message" do
			it "greets players" do
				game = Game.new([bob,frank])
				expected = "Welcome to Tic Tac Toe"
				expect(game.welcome_message).to eq expected
			end
		end
		
		context "#solicit_move" do
			it "asks the player to make a move" do
				game = Game.new([bob, frank])
				allow(game).to receive(:current_player) {bob}
				expected = "Bob: Enter a number between 1 and 9 to make your move or enter 'quit' to close the program"
				expect(game.solicit_move).to eq expected
			end
		end

		context "#get_move" do
			it "converts human move of '1' to [0,0]" do
				game = Game.new([bob, frank])
				expect(game.get_move("1")).to eq [0,0]
			end

			it "converts human move of '7' to [0,2]" do
				game = Game.new([bob, frank])
				expect(game.get_move("7")).to eq [0,2]
			end

			it "calls #human_move_to_coordinate" do
				game = Game.new([bob, frank])
				expect(game).to receive(:human_move_to_coordinate).with("x")
				game.get_move("x")
			end
		end

		context "#check_if_quit" do 
			it "exits if player types 'quit'" do #it doesn't work properly
				game = Game.new([bob, frank])
				game.instance_variable_set(:@human_move, "quit")
				expect{game.check_if_quit; exit}.to raise_error SystemExit
			end
		end

		context "valid_input" do
			it "returns true if player's choice is a number between 1 and 9" do
				game = Game.new([bob, frank])
				game.instance_variable_set(:@human_move, "8")
				expect(game.valid_input).to be true
			end

			it "returns false if player's choice isn't a number between 1 and 9" do
				game = Game.new([bob,frank])
				game.instance_variable_set(:@human_move, "blep2")
				expect(game.valid_input).to be false
			end
		end


		context "#game_over_message" do
			it "returns '{current player name} won!' if board shows a winner" do
				game = Game.new([bob, frank])
				expect(game).to receive(:current_player) {bob}
				expect(game.board).to receive(:game_over) {:winner}
				expect(game.game_over_message).to eq "Bob won!"
			end
		end

	end
end