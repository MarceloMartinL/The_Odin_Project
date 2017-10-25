lolo = Proc.new {|x| x+1}

module Enumerable

	def my_each
		return self.to_enum unless block_given?
    i = 0
			if self.is_a? Array 
		    while i < self.length
		    	yield(self[i])
		    	i += 1	
		  	end
		  else
		    for key in self.keys
		    	yield(key, self[key])
		    end
	  	end
    self
	end 

  def my_each_with_index
  	return self.to_enum unless block_given?
  	i = 0
  	if self.is_a? Array
    	while i < self.length
    		yield(self[i], i)
    		i += 1
    	end
    elsif self.is_a? Hash
    	for item in self.to_a
    		yield(item, i)
    		i += 1
    	end
    end
    self
  end

  def my_select
  	return self.to_enum unless block_given?
  	result = []
    if self.is_a? Array
      for item in self
      	result.push(item) if yield(item)
      end
    elsif self.is_a? Hash
    	for key, value in self
    		result.push([key, value]) if yield(key, value)
    	end
    end
    result 
  end

  def my_all?
    test = true
    if block_given?
      if self.is_a? Array
        for item in self	
        	if yield(item) == true
        		test = true
        	else
        		test = false
        		break
          end   
        end
      elsif self.is_a? Hash
      	for key, value in self
        	if yield(key, value) == true
        		test = true
        	else
        		test = false
        		break
        	end
        end
      end
    else
      for item in self
        if item == nil || item == false
          test = false
          return test
        else
          next
        end
      end
    end
    return test
  end

  def my_any?	
  	test = false
    if block_given?
    	if self.is_a? Array
    		for item in self
    			if yield(item) == true
    				test = true
    				break
    			else
    				next
    			end
    		end
    	elsif self.is_a? Hash
    		for key, value in self
    			if yield(key, value) == true
    				test = true
    				break
    			else
    				next
    			end
    		end
    	end 
    else 
      for item in self
        if item == nil || item == false
          test = false
        else
          test = true
          break
        end
      end
    end
    test
  end

  def my_none?
  	return self unless block_given?
  	test = false
  	if self.is_a? Array 
  		for item in self
  			if yield(item) == true
  				test = false
  				break
  			else
  				test = true
  			end
  		end
  	elsif self.is_a? Hash 
  		for key, value in self
  			if yield(key, value) == true
  				test = false
  				break
  			else
  				test = true
  			end
  		end
  	end
  	return test
  end

  def my_count
  	if block_given?
      count = 0
      for i in self
        count += 1 if yield(i)
      end
    else
      count = 0
      for i in self
        count += 1
      end
    end
    count
  end

  def my_map(param = nil)
    return self.to_enum unless block_given?
    arr = []
  	if self.is_a? Array 
  		for item in self
  			arr << param.call(item) if param != nil 
  			arr << yield(item) if param == nil && block_given?
  		end
  	elsif self.is_a? Hash 
  	  for key, value in self
  	  	arr << param.call(key, value) if param != nil
  	  	arr << yield(key, value) if param == nil && block_given?
  	  end
  	end
  	arr
  end

  def my_inject(var = nil)

    if block_given?
    	arr = self.to_a
    		if var == nil
    			total = arr[0]  
    		  for item in arr.drop(1)
    			  total = yield(total, item)
    			end	

    	  else 
    	    total = var
    	    for item in arr
    	      total = yield(total, item)
    	    end 				
    	  end	
      total
    end
  end
end



 