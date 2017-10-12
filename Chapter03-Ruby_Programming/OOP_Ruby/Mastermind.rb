class Mastermind

	def initialize
		@colors = ["R","B","Y","G","M","C"]
		@turn = 12
	end

	def start
		puts "¡Welcome to Mastermind!"
		puts 
		puts "The rules are simple:"
		puts "This is a 2 players game, where the players choose beetwen 2 roles: The Codebreaker or The Codemaker."
		puts "The Codemaker start creating a hidden code, choosing a random combination of 4 colors from the 6"
		puts "available [(R)ed, (B)lue, (G)reen, (Y)ellow, (M)agenta and (C)yan]."
		puts "Then the Codebreaker has 12 turns to guess the code (combination of 4 colors), in both order and color,"
		puts "using the first letter of each color, like this: RGBY."
		puts "After each guess the Codebreaker recibe feedback from the Codemaker, giving him a \"W\" hint for each"
		puts "color that was correct but in the wrong position, and a \"B\" hint when a color and his position are correct."
		puts
		puts "Please choose a role:" 
		puts "1.- Codebreaker" 
		puts "2.- Codemaker"
		role = gets.chomp.to_i

		if role == 1
			@random_code = []
			4.times do 
				@random_code.push(@colors[rand(6)])
			end
			play
		elsif role == 2
			puts "Choose the secret code"
			@random_code = Array.new(gets.chomp.upcase.scan(/\w/))
			play_ai
		end	
		puts "Random code: #{@random_code}"		
	end

	def play_ai
		@player_code = []
		4.times do
			@player_code.push(@colors[rand(6)])
		end

		while @turn > 0 || game_over == false

			hints = []
			overlap = []
			#This array holds the "Black" answers (Both correct color and position)
			computer_ai = ["", "", "", ""]
			#This array holds the "White" answers (Correct color but wrong position)
			computer_white = ["", "", "", ""]

			@random_code.each_with_index do |item, index|
				@player_code.each_with_index do |x, y|
					if x == item && y == index
						if overlap.include?([x, y]) && overlap.include?([item, index])
							computer_ai[y] = x
							computer_white.delete(x)
							hints.delete("W")
							hints.push("B")
						else
							overlap.push([x, y], [item, index])
							computer_ai[y] = x
							hints.push("B")
						end
					elsif x == item && y != index
						if overlap.include?([x, y]) || overlap.include?([item, index])
							next
						else
							overlap.push([x, y], [item, index])
							hints.push("W")
							computer_white[y] = x
						end
					end
				end
			end
			puts
      puts "Player Code: #{@player_code}"
      puts "Hints: #{hints}, the computer has #{@turn} turns left."
      puts
      @turn -= 1
	    game_over
    	@player_code = computer_ai

	    if @player_code.include?("") == true 
    		while @player_code.include?("") == true
		    	if computer_white.uniq.size != 1
		    		@player_code.each_with_index do |item, index|
		    			computer_white.each_with_index do |x, y|
		    				if item == "" && index != y
		    					@player_code[index] = x
		    					computer_white[y] = ""
				  			elsif item == "" && index == y
				  				@player_code[index] = @colors[rand(6)]
				  				next
				  			end
				  		end    				
		    		end
		    	else
		        @player_code.each_with_index do |item, index|
		        	if item == ""
		        		@player_code[index] = @colors[rand(6)]
		        	else
		        		next
		    			end
		    		end
		    	end
	      end 
	    end
		end
	end

	def play
		while @turn > 0
			puts "You are the Codebreaker!" 
			puts "Choose a combination of 4 colors (R)ed, (B)lue, (G)reen, (Y)ellow, (M)agenta or (C)yan"
			@player_code = Array.new(gets.chomp.upcase.scan(/\w/))
			hints = []
			overlap = []
			@random_code.each_with_index do |item, index|
				@player_code.each_with_index do |x, y|
					if x == item && y == index
						if overlap.include?([x, y]) && overlap.include?([item, index])
							hints.delete("W")
							hints.push("B")
						else
							overlap.push([x, y], [item, index])
							hints.push("B")
						end
					elsif x == item && y != index
						if overlap.include?([x, y]) || overlap.include?([item, index])
							next
						else
							overlap.push([x, y], [item, index])
							hints.push("W")
  					end
					else
						next
					end
				end
			end
			@turn -= 1
			game_over
			puts
			puts "Player guess: #{@player_code}"
			puts "Hints: #{hints}, you have #{@turn} turns left."
			puts
		end
	end

	def game_over
		if @player_code == @random_code
			puts "The Code is CORRECT!!!"
			puts "GAME FINISHED! The Codebreaker WON!!!"
			exit
		elsif @turn <= 0
			puts "The Codebreaker has no turns left."
			puts "GAMES FINISHED! The Codemaker WON!!!"
			exit
		end	 	 
	end
end

game = Mastermind.new
game.start