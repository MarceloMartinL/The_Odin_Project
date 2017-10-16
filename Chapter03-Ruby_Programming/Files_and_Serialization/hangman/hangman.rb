require 'yaml'

class Hangman
	attr_accessor 
	def initialize(turn=9,tablet=[],incorrect_letters=[],secret_word=nil, secret_word_arr=nil)
		@turn = turn
		@tablet = tablet
		@incorrect_letters = incorrect_letters
		@secret_word = secret_word
		@secret_word_arr = secret_word_arr
		@save_arr = [@turn, @tablet, @incorrect_letters, @secret_word, @secret_word_arr]
	end

	def start
		puts "¡Welcome to Hangman!"
		puts "The computer randomly choose a word between 5-12 characters length"
		puts "You have 9 turns to guess the word, OR SOMEONE IS GONNA DIE!"
		puts "Please choose an option:"
		puts "1.- New Game"
		puts "2.- Load a Game"
		player_choice = gets.chomp
		puts

		if player_choice == "1"

			dictionary = File.readlines('5desk.txt')
			@secret_word = ""

			# Loop until secret_word gets assigned a word between 5 and 12 characters length.
			until @secret_word.size >= 5 && @secret_word.size < 13
				@secret_word = dictionary[rand(61407)].strip.upcase
			end

			@secret_word_arr = @secret_word.scan(/./)
			display	

		elsif player_choice == "2"
			Hangman.load_game
		end
	end

	def play
		puts "[1]Save game or [2]Exit"
		puts "Please choose a letter (from A to Z)."
		input = gets.chomp.upcase
		puts

		if input == "1"
			save_game
		elsif input == "2"
			puts "Game closing... BYE BYE!!!"
			exit
		else

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

def to_yaml
		YAML.dump ({
			:turn => @turn,
			:tablet => @tablet,
			:incorrect_letters => @incorrect_letters,
			:secret_word => @secret_word,
			:secret_word_arr => @secret_word_arr
			})
end

	def save_game
		save_file = self.to_yaml
		puts "Please enter a name for your save"
		input_save = gets.chomp.downcase
		
		File.open(input_save, "w") do |file| 
			file.puts save_file 
		end
		puts "Your game has been saved as: #{input_save}"
		puts
		display
	end

	# Verify if saved file exist, if exist then load it else ask again.
	def self.load_game
		puts "Please enter the name of your saved game"
		input_load = gets.chomp.downcase
		puts
		data = YAML.load(File.read(input_load))
		load_game = self.new(data[:turn], data[:tablet], data[:incorrect_letters], data[:secret_word], data[:secret_word_arr])
		load_game.display
	end
		
	
end

game = Hangman.new
game.start