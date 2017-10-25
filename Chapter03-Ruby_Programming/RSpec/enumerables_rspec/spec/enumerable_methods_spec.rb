require 'enumerable_methods'

describe Enumerable do 

	let (:base_arr) {[1, 2, 3]}
	let (:empty_arr) {[]}

	describe "#my_each_with_index" do 

		context "when no block is given" do
			it "returns an enumerator object" do
				expect(base_arr.my_each_with_index).to be_instance_of(Enumerator)
			end
		end

		context "when a block is given" do
			it "yields the block with the item and its index" do
				base_arr.my_each_with_index {|item, index| puts empty_arr << item + index}
				expect(empty_arr).to eql([1,3,5])
			end

			it "returns an Array object" do
				expect(base_arr.my_each_with_index {|item, index|}).to be_instance_of(Array)
			end
		end
	end	

	describe "#my_select" do

		context "when no block is given" do
			it "returns an Enumerator object" do
				expect(base_arr.my_select).to be_instance_of(Enumerator)
			end

			it "returns the same group of elements" do
				expect(base_arr.my_select).to contain_exactly(1,2,3)
			end
		end

		context "when a block is given" do
			it "returns an Array object" do
				expect(base_arr.my_select {|item| item > 2}).to be_instance_of(Array)
			end

			it "returns all elements for which the block evaluates as true" do
				expect(base_arr.my_select {|item| item > 2}).to eql([3])
			end
		end
	end

	describe "#my_all?" do

		context "when no block is given" do
			context "for a group of elements without nil or false" do
				it "returns true" do
					expect(base_arr.my_all?).to eql(true)
				end
			end
		end

		context "given a block condition" do
			it "returns false if a single element evaluates as false" do
				expect(base_arr.my_all? {|item| item < 3}).to eql(false)
			end

			it "returns true if all elements evaluates as true" do
				expect(base_arr.my_all? {|item| item < 5}).to eql(true)
			end
		end
	end

	describe "#my_any?" do

		context "when no block is given" do
			context "if atleast one element is not nil or false" do
				it "returns true" do
					expect(base_arr.my_any?).to eql(true)
				end
			end
		end

		context "when a condition block is given" do
			context "if atleast one element evaluates as true" do 
				it "returns true" do
					expect(base_arr.my_any? {|item| item == 3}).to eql(true) 
				end
			end

			context "if none element evaluates as true" do
				it "returns false" do 
					expect(base_arr.my_any? {|item| item > 4}).to eql(false)
				end
			end
		end
	end

	describe "#my_map" do

		context "when no block is given" do 
			it "returns an enumerator object" do
				expect(base_arr.my_map).to be_instance_of(Enumerator)
			end
		end

		context "when a block is given" do
			it "returns a new array object" do 
				expect(base_arr.my_map {|item| item + 2}).to be_instance_of(Array)
			end

			it "returns the result of running the block for every element" do
				expect(base_arr.my_map {|item| item +2}).to eql([3,4,5])
			end
		end

		context "when a block and a proc are given" do
			it "only execute the proc" do
				lolo = Proc.new {|x| x+1}
				expect(base_arr.my_map(lolo) {|x| x**2}).to eql([2,3,4])
			end
		end
	end

	describe "#my_inject" do

		context "when no block is given" do
			it "returns nil" do
			  expect(base_arr.my_inject).to eql(nil)
			end
		end


		context "when a block is given" do
			context "when no argument is given" do 
				it "uses the first element as the initial accumulator value" do
					expect(base_arr.my_inject {|accumulator, item| accumulator}).to eql(1)
				end
			end

			context "when an argument is given" do
				it "uses the argument as initial accumulator value" do
					expect(base_arr.my_inject(5) {|accumulator, item| accumulator + item}).to eql(11)
				end
			end
		end
	end
end