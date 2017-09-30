dictionary = ["how", "are", "you", "ruby", "what", "from", "since", "down", "go", "up", "before", "above", "much", "low", "partner", "it", "is", "was", "were", "hello", "world"]

def substring (string, dictionary)
  matchlist = {} 
  
  dictionary.each do |x|
  	i = 1
    string.scan(x) do |word| 
      if matchlist.include?(word)
  	    matchlist[word] = 1 + i
  	    i += 1

  	  else
  	    matchlist[word] = 1
  	  end

    end
  end
  puts matchlist
  #string.scan(dictionary) {|letter| puts letter}
end

substring("hello hello you are awesome ruby you java world again", dictionary)