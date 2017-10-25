require 'tic_tac_toe.rb'

describe Board do 

	let(:player1) {Player.new("Player1", "x")}
	let(:player2) {Player.new("Player2", "o")}
	let!(:game)   {Board.new(player1, player2)}

	describe "#win_condition" do 
		
		before do 
			allow(game).to receive(:name)
		end

		context "when board reads the same mark" do
			context "across a top row" do 
				it "returns true" do
					@@arr = ["x","x","x",4,5,6,7,8,9]
					expect(game.win_condition).to eql(true)
				end
			end

			context "across the mid row" do 
				it "returns true" do
					@@arr = [1,2,3,"x","x","x",7,8,9]
					expect(game.win_condition).to eql(true)
				end
			end

			context "across the bot row" do 
				it "returns true" do
					@@arr = [1,2,3,4,5,6,"x","x","x"]
					expect(game.win_condition).to eql(true)
				end
			end

			context "across a column" do
				it "returns true" do
					@@arr = [1,"x",3,4,"x",6,7,"x",9]
					expect(game.win_condition).to eql(true)
				end
			end

			context "across a diagonal (top-left to bot-right)" do 
				it "returns true" do 
					@@arr = ["x",2,3,4,"x",6,7,8,"x"]
					expect(game.win_condition).to eql(true)
				end
			end

			context "across a diagonal (top-right to bot-left)" do 
				it "returns true" do 
					@@arr = [1,2,"x",4,"x",6,"x",8,9]
					expect(game.win_condition).to eql(true)
				end
			end
		end
	end

	describe "#draw_condition" do 

		context "when the win condition doesn't trigger and there are no spaces left" do 
			it "returns true" do
				@@arr = ["x","o","x","x","x","o","o","o","x"]
				expect(game.draw_condition).to eql(true)
			end
		end
	end

	describe "#display" do 

		context "when game initialize" do 
			it "displays the game board" do 
				expect(game).to receive(:display)
				game.display
			end
		end
	end

end


describe Player do 

	let(:player1) {Player.new("Player1", "x")}
	let(:player2) {Player.new("Player2", "o")}
	let!(:game)   {Board.new(player1, player2)}

	describe "#change_player" do 

		context "when player1 is playing" do 
			it "changes to player2" do 
				allow(player2).to receive(:play)
				expect(player1.change_player).to eql(player2.play)
			end
		end
	end
end
