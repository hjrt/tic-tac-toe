module TicTacToe
  class Player
    attr_reader :color, :name

    def initialize(input)
      @color = input.fetch(:color)
      @name = input.fetch(:name)
    end
    
    def color=(color)
    	@color = color
    	if color == "X"
      	@opponent_color = "O"
    	else
      	@opponent_color = "X"
    	end
  	end
  
  end
end