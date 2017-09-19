#write your code here
def translate word
  group = word.split
  consonant = ['q', 'w', 'r', 't', 'y', 'p', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm']
  
  group.each do |word|
    x = word.length
    
      if consonant.include?(word[0])
        x.times do 
         if word[0..1] == 'qu'
            word.insert(-1, 'qu')
            word.sub!(word[0..1], '')
            
          elsif consonant.include?(word[0])
            word.insert(-1, word[0])
            word.sub!(word[0], '')
          else
            break
          end
        end
        word.insert(-1, 'ay')

      else
        word.insert(-1, 'ay')
      end  
  end
  group.join(' ')
end