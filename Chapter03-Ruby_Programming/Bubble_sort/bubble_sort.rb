# Build a method #bubble_sort that takes an array and returns a sorted 
# array. It must use the bubble sort methodology (using #sort would be 
# pretty pointless, wouldn't it?).

def bubble_sort(array)
	sort_list = array.clone
	iterations = (array.length - 1) ** 2
	i = 0

	iterations.times do |item|

		if sort_list[i] > sort_list[i+1]
			sort_list[i], sort_list[i+1] = sort_list[i+1], sort_list[i]
      if i >= array.length - 2
        i = 0
      else
			  i += 1
		  end
    else
    	if i >= array.length - 2
    		i = 0
      else
        i +=1
      end
    end
  end
  puts sort_list
end

# Now create a similar method called #bubble_sort_by which sorts an 
# array but accepts a block. The block should take two arguments 
# which represent the two elements currently being compared. Expect 
# that the block's return will be similar to the spaceship operator you 
# learned about before -- if the result of the block is negative, the 
# element on the left is "smaller" than the element on the right. 0
# means they are equal. A positive result means the left element is 
# greater. Use this to sort your array.

def bubble_sort_by(array)
	final_list = array.clone
	iterations = (array.length - 1) ** 2
	i = 0

	iterations.times do |x|

  swap = yield(final_list[i], final_list[i+1])
  	if swap == -1
  		if i >= array.length - 2
  		  i = 0
  		else
  			i += 1
  	  end
  	elsif swap == 1
  		final_list[i], final_list[i+1] = final_list[i+1], final_list[i]
  			if i >= array.length - 2
  		  	i = 0
  			else
  				i += 1
  			end
  	else
  	  if i >= array.length - 2
  		  i = 0
  		else
  			i += 1
  		end
  	end
  end
  puts final_list
end

bubble_sort_by([11,2,9,4,15,1,3,5]) do |item1, item2|

	if item1 < item2
	 -1
  elsif item1 > item2
  	1
  else
  	0
  end
end