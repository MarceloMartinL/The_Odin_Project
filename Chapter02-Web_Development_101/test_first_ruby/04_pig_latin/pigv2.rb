#write your code here
def translate word
  agroup = word.split
  vowel = ['a', 'e', 'i', 'o', 'u']
  agroup.each do |word|
    if vowel.include?(word[0])
	    word.insert(-1, 'ay')
    
    else 
      if vowel.include?(word[1])
  	    word.insert(-1, word[0])
        word.sub!(word[0], '')
  	    word.insert(-1, 'ay')

  	  elsif vowel.include?(word[2])
        2.times do 
        word.insert(-1, word[0])
        word.sub!(word[0], '')
        end
        word.insert(-1, 'ay')

      elsif vowel.include?(word[3])
        3.times do
        word.insert(-1, word[0])
        word.sub!(word[0], '')
        end
        word.insert(-1, 'ay')

        elsif vowel.include?(word[4])
        4.times do
        word.insert(-1, word[0])
        word.sub!(word[0], '')
        end
        word.insert(-1, 'ay')
      end
    end
  end
  agroup.join(' ')
end