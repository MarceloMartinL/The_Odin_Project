#write your code here
def echo word
	word
end

def shout word
    word.upcase
end

def repeat word, num = 2
	a = (word+' ') * num
	a.strip
end

def start_of_word word, num
	wordVar = word
	length = word.length

	wordVar[0, (num)]
end

def first_word sentence
	a = sentence.split
	a[0]
end

def titleize word
	a = word.split
	
	a.each do |i|
	 c = i.length
	
      if c > 4 or i == a[0] or i == a.last
      i.capitalize!
	  end
	end

	b = a.join(' ')
	b
end

