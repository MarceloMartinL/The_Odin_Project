require 'caesar_cipher.rb'

describe "#caesar" do

	context "given a empty string" do
		it "return a empty string" do
			expect(caesar("", 2)).to eql("")
		end
	end

	context "given a letter and a positive number" do
		it "return the letter 'number' positions right on the alphabet" do
			expect(caesar("a", 3)).to eql("d")
		end
	end		

	context "given a letter and a negative number" do
		it "return the letter number positions left on the alphabet" do
			expect(caesar("d", -3)).to eql("a")
		end
	end

	context "when reach the final of the alphabet" do
		it "properly wraps to the start" do
			expect(caesar("z", 4)).to eql("d")
		end
	end

	context "when reach the start of the alphabet" do
		it "properly wraps backwards to the end" do
			expect(caesar("a", -4)).to eql("w")
		end
	end

	context "given a string with different case letters" do
		it "properly keeps the case letters" do
			expect(caesar("aBcD", 2)).to eql("cDeF")
		end
	end

	context "given a string with blank spaces" do
		it "properly keeps the spaces" do
			expect(caesar("a b c", 2)).to eql("c d e")
		end
	end

	context "given a string with special characters" do
		it "doesn't cipher the special characters" do
			expect(caesar("$#%&", 5)).to eql("$#%&")
		end
	end
end