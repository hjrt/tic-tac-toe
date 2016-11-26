module TicTacToe
  class Player
    attr_reader :color, :name, :opponent_color

    def initialize(input)
      @color = input.fetch(:color)
      @name = input.fetch(:name)
    end
    
    def opponent_color
    	if self.color == "X"
      	"O"
    	else
      	"X"
    	end
  	end
  
  end
end