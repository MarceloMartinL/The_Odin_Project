class Book
# write your code here
def title= (word)
	capitalize(word)
	@title = @b
end

def title
	@title
end

def capitalize titles
	a = titles.split
	conjunctions = ['and', 'in', 'the', 'of', 'a', 'an']
	a.each do |i|
		if conjunctions.include?(i) == false or i == a[0]
		i.capitalize!
	    end
	end
	@b = a.join(' ')
    
end

end