# Linkedlist class will represent the full linked list.
class Linkedlist
	attr_reader :head, :tail

	def initialize
		@head = nil
		@tail = nil
	end

# Adds a new node to the end of the list.
	def append(data)
  	node = Node.new(data)
  	if @head == nil
  		@head = node
  		@tail = node
  	else
  		tmp = @head
  		while tmp.next != nil
  			tmp = tmp.next
  		end
  		tmp.next = node
  		@tail = node
  		node.next = nil
  	end
  	node
	end

# Addds a new node to the start of the list.
	def prepend(data)
		node = Node.new(data)
		if @head == nil
			@head = node
			@tail = node
		else
			node.next = @head
			@head = node
		end
	end

# Returns the total number of nodes in the list.
	def size
		count = 0
		if @head == nil
			count
		else
			count = 1
			tmp = @head
			while tmp.next != nil
				tmp = tmp.next
				count += 1
			end
			count
		end
	end

# Returns the node at the given index.
	def at(index)
		count = 1
		if @head == nil
			return nil
		else
			tmp = @head
			until count == index 
				if tmp.next == nil
					return nil
				else
					tmp = tmp.next
					count += 1
				end
			end
		end
		tmp
	end

# Removes the last node of the list.
	def pop
		if @head == nil
			return nil
		else
			tmp = at(self.size - 1)
			deleted = @tail
			@tail = tmp
			tmp.next = nil
			deleted
		end
	end

# Returns True if the passed in value is in the list, otherwise return False.
	def contains?(value)
		result = false
		if @head == nil
			return false
		else
			tmp = @head
			until tmp.data == value
				if tmp.next == nil
					return false
				else
					tmp = tmp.next
				end
			end
			result = true
		end
		result
	end

# Returns the index of the node containing the value, or nil if not found.
	def find(value)
		count = 1
		if @head == nil
			return nil
		else
			tmp = @head
			while tmp !=  nil	
				if tmp.data == value
					return count
				else
					tmp = tmp.next
					count += 1
				end
			end
			return nil
		end		
	end

# Represent the full Linked list objects as strings.
	def to_s
		if @head == nil
			return nil
		else
			tmp = @head	
			str = ""
			while tmp != nil
				if tmp == @tail
					str += "(#{@tail.data}) -> nil"
					return str
				else
					str += "(#{tmp.data}) -> "
					tmp = tmp.next
				end
			end
		end
	end

# Insert a node at the given index.
	def insert_at(data=nil,index)
		node = Node.new(data)
		if @head == nil || index > self.size
			return nil
		else
			prev_node = at(index - 1)
			mid_node = at(index)
			prev_node.next = node
			node.next = mid_node
		end
		node
	end

# Remove the node at the given index.
	def remove_at(index)
		if self.size == 0 || index > self.size 
			return nil
		else
			prev_node = at(index - 1)
			mid_node = at(index)
			if mid_node.next == nil
				prev_node.next = nil
				@tail = prev_node
			else
				prev_node.next = mid_node.next
			end
		end
	end
end

class Node
	attr_accessor :data, :next

	def initialize(data=nil)
		@next = nil
		@data = data
	end
end


list = Linkedlist.new
list.append("marcelo")
list.append("matias")
list.append("felipe")
puts list.size
puts list.at(1).data
puts list.contains?("jajaja")
puts list.contains?("felipe")
puts list.contains?("marcelo")
puts list.find("marcelo")
puts list.find("mojojojo")
puts list.find("felipe")
list.insert_at("kaori",3)
puts list.to_s
list.remove_at(4)
puts list.tail.data
puts list.to_s

