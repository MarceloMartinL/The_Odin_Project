class BinaryTree
	attr_accessor :root

	def initialize(arr)
		@root = nil
		@arr = arr
		build_tree(arr)
	end

# Build the base of the BinaryTree (first 3 elements).
	def build_tree(arr)
		@root = Node.new(arr[(arr.size/2)])   # Set a random element from the mid of the array as the @root.
		arr.delete_at(arr.size/2)             # and delete that element from the array       

	# Iterate through the array until both l_child and r_child has been set for the @root.
		until @root.l_child != nil && @root.r_child != nil
			arr.each_with_index do |value, index|
				if value < @root.value && @root.l_child == nil
					node = Node.new(value)
					@root.l_child = node
					node.parent = @root
					arr.delete_at(index)             # And eliminate those elements from the array when choosen.
				elsif value > @root.value && @root.r_child == nil
					node = Node.new(value)
					@root.r_child = node
					node.parent = @root
					arr.delete_at(index)
				end
			end
		end
		insert_nodes(arr)
	end

# Complete the BinaryTree adding the remaining elements of the array.
	def insert_nodes(arr)
		arr.each do |value|
			node = Node.new(value)
			tmp = @root

			# Travel across the Tree until the correct level and available spot is found for the element.
			while (node.value < tmp.value && tmp.l_child != nil) || (node.value > tmp.value && tmp.r_child != nil)
				if node.value < tmp.value
					tmp = tmp.l_child
				else
					tmp = tmp.r_child
				end
			end

			# Once in the correct BinaryTree level set the correct child and parent relationship.
			if node.value < tmp.value
				node.parent = tmp
				tmp.l_child = node

			else
				node.parent = tmp
				tmp.r_child = node
			end
		end
		p arr
	end

# Search for the element in all the nodes of the same level in the BinaryTree by queueing each noded childrens
	def breadth_first_search(value)
		return nil if @root == nil
		queue = []
		queue << @root
		while !queue.empty?
			if queue[0].value == value
				return queue[0]
			else
				queue << queue[0].l_child if queue[0].l_child != nil
				queue << queue[0].r_child if queue[0].r_child != nil
				queue.shift
			end
		end
		puts "Not found"
		return nil
	end

# Search for the element completing each subtree before looking at the other.
	def depth_first_search(value)
		return nil if @root == nil
		stack = []
		stack << @root
		while !stack.empty?
			target = stack[-1]
			stack.pop
			return target if target.value == value
			stack << target.r_child if target.r_child != nil
			stack << target.l_child if target.l_child != nil
		end
		puts "Not found"
		return nil
	end

# Recursive method for the depth first search.
	def dfs_rec(value, root=@root)
		
		return nil if root == nil
		return root if value == root.value

		a = dfs_rec(value, root.l_child)
	 	b = dfs_rec(value, root.r_child)	

	 	return a if a != nil
	 	return b if b != nil
	end
end

class Node
	attr_accessor :parent, :value, :l_child, :r_child

	def initialize(value=nil)
		@value = value
	end
end

arr = [1, 7, 44, 58, 23, 8, 3, 35]
tree = BinaryTree.new(arr)

puts tree.root.l_child.value
puts tree.root.value
puts tree.root.r_child.value
p tree.breadth_first_search(35).value
p tree.depth_first_search(1).value
p tree.dfs_rec(3)