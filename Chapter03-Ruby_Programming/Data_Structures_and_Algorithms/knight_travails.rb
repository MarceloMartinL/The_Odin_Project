# Project: Knight Travails
# A knight in chess can move to any square on the standard 8x8 chess board from any other 
# square on the board, given enough turns. Its basic move is two steps forward and one step 
# to the side. It can face any direction.
# Build a function ::knight_moves that shows the simples possible way to get from one
# square to another by outputting all squares the knight will stop on along the way.

class Knight
	def initialize(start, final)
		@start = start
		@final = final
		@revised = []
		@queue = []
		@row = [-2, -2, -1, 1, 2, 2, 1, -1,]
		@col = [1, -1, -2, -2, -1, 1, 2, 2]
		knight_moves
	end

# Method based on the BFS algorithm to find the shortest path between the given coordinates presuming a 8x8 Chess Board.
	def knight_moves
		node = Square.new(@start)
		@queue << node
		while @queue.empty? == false
			current = @queue[0]
			if current.value == @final
				display_result(current)			
			else

				8.times do |num|
					x = current.value[0] + @row[num]
					y = current.value[1] + @col[num]
					if (x.between?(1,8) && y.between?(1,8)) && @revised.include?([x, y]) == false
						node = Square.new([x, y])
						node.parent = current
						node.count = current.count + 1
						@queue << node
					else
						next
					end
				end
				@revised << current.value
				@queue.shift
			end
		end
		puts "NOT FOUND !!!"
		puts "This program presumes a 8x8 Chess Board"
		puts "Therefore your coordinates must be between (1, 1) and (8, 8)."
	end

# Display the final results from the BFS.
	def display_result(obj)
		node = obj
		arr = []
		n = node.count + 1
		puts "From #{@start} to #{@final}"
		puts "Total movements: #{node.count}"
		n.times do  
			arr << node
			node = node.parent
		end

		arr.reverse.each do |item|
			p item.value
		end
		exit

	end
end

class Square 
	attr_accessor :value, :count, :parent
	def initialize(value)
		@value = value
		@count = 0
		@parent = nil
	end
end

board = Knight.new([1,1], [8,5])
