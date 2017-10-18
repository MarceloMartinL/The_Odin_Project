# Recursive method that uses the merge_sort algorithm to sort an array list. (Divide & Conquer)
def merge_sort(array)
	n = array.size
	if n < 2    # if n < 2 then there is only 1 number on the array, so we just return.
		return array		
	else
		a = merge_sort(array[0,n/2])  # We recursively call the method again but with the first half of the original array.
		b = merge_sort(array[n/2, n]) # We do the same with the second half of the array, until we get arrays of only 1 number.
		c = []                        # This empty list is where we will be adding the result of the element comparison.

		until a.empty? || b.empty?  # This sections is a loop that always compares the first element of each array list (a and b)
			if a[0] < b[0]            # The lower of the two elements is added to a third empty list (c) and that element is deleted
				                        # From his original list (a or b) so it doesnt repeat.
				c << a[0]               # The loop continues until one of the list's gets empty.
				a.shift
			else
				
				c << b[0]
				b.shift
			end
		end

		if a.empty?                # When one of the lists gets empty we just add the remainder elements of the other list 
			c += b                   # (which is already sorted) to the C list, which acts like the "result list".
		else b.empty?
			c += a
		end
		c
	end
	 
end

 p merge_sort([1,6,4,2,5,3])

