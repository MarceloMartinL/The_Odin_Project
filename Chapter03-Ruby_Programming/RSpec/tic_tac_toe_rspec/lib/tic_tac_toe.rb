class Board 
	attr_accessor :arr, :player1, :player2

	def initialize(player1, player2)
		@@arr = [1,2,3,4,5,6,7,8,9]                
		@@player1 = player1
		@@player2 = player2
		display
		player_start
	end

	def win_condition
		@win_condition = [[@@arr[0], @@arr[1], @@arr[2]], [@@arr[3], @@arr[4], @@arr[5]], [@@arr[6], @@arr[7], @@arr[8]],
	                    [@@arr[0], @@arr[3], @@arr[6]], [@@arr[1], @@arr[4], @@arr[7]], [@@arr[2], @@arr[5], @@arr[8]],
	                    [@@arr[0], @@arr[4], @@arr[8]], [@@arr[2], @@arr[4], @@arr[6]]]	

		@win_condition.each do |x|
			if x.uniq.size == 1
				return true
			else
			  next
			end
		end
	end	

	def game_over
		if win_condition == true
			puts "Game Finished! #{self.name} WON the game!!!"
			exit
		elsif draw_condition == true
			puts "DRAWWW!!! The game has ended!"
			exit
		end
	end

	def draw_condition
		if @@arr.all? {|x| x.class != Fixnum}
			return true
  	end
	end

	def player_start
		player = rand(1..2)
			if player == 1
				@@player1.play
			else
				@@player2.play
			end
	end

	def display
		puts
		puts "#{@@arr[0]}|#{@@arr[1]}|#{@@arr[2]}\n#{@@arr[3]}|#{@@arr[4]}|#{@@arr[5]}\n#{@@arr[6]}|#{@@arr[7]}|#{@@arr[8]}"
	end
end

class Player < Board
	attr_accessor :name, :mark

	def initialize(name, mark)
		@name = name.capitalize
		@mark = mark.upcase
	
  end

  def play
  	puts
  	puts "#{@name} please enter the position for your mark (1 - 9)"
  	input_validation = false

    while input_validation == false
  		mark_position = gets.chomp
  		if @@arr[mark_position.to_i - 1].class == Fixnum
  	  	@@arr[mark_position.to_i - 1] = @mark 
  	  	input_validation = true 
  		else
  			puts "This position is already taken. Please choose a new one"
  		end
  	end  
  	display
  	game_over
  	change_player
  end

  def change_player
  	if self.name == "Player1"
  		@@player2.play
  	else
  		@@player1.play
  	end
  end
end

#player1 = Player.new("Player1", "x")
#player2 = Player.new("Player2", "o")
#game = Board.new(player1, player2)
