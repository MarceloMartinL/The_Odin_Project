class Hangman
	def initialize
		@turn = 9
		@tablet = []
		@incorrect_letters = []
	end

	def start
		dictionary = File.readlines('5desk.txt')
		@secret_word = ""

		# Loop until secret_word gets assigned a word between 5 and 12 characters length.
		until @secret_word.size >= 5 && @secret_word.size < 13
			@secret_word = dictionary[rand(61407)].strip.upcase
		end

		@secret_word_arr = @secret_word.scan(/./)
		puts @secret_word
		display	

	end

	def play
		puts "Please choose a letter from A to Z"
		input = gets.chomp.upcase
		puts

		if !@secret_word_arr.include?(input)
				if @incorrect_letters.include?(input)
					puts "You already try #{input} and it was wrong!!! I discount you 1 turn for being retarded."
					puts "Muahahahaha."
					puts
				else
					@incorrect_letters << input
				end
		else
			@secret_word_arr.each_with_index do |letter, index|
				if letter == input
					@tablet[index] = letter
				end
			end
		end
		@turn -= 1
		game_over
		display
	end

	def game_over
		if @tablet.include?("-") == false
			puts "Game Finish!\nThe guesser WON THE GAME!!!"
			exit
		elsif @turn < 1
			puts "Game Finish!\nThe hanged man DIES!!!"
			puts "The hidden word was: #{@secret_word}"
			exit
		end
	end

	def display
		if @turn == 9
			@secret_word.size.times do 
				@tablet << "-"
			end
		end
		puts @tablet.join(" ")
		puts "Incorrect: #{@incorrect_letters}  Turns left: #{@turn}"
		puts
		play
	end
end

game = Hangman.new
game.start