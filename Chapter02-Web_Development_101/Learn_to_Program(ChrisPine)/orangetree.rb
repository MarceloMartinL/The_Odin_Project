class OrangeTree
  
  def initialize
    @treeHeight = 50
    @treeOrange = 0
    @treeYears = 0

    puts 'Your new Orange Tree has germinated!'
  end

  def countTheOrange
    if @treeOrange == 0
      puts 'You go to count the number of oranges on your tree but you realize your tree still doesn\'t have oranges.'
    end

  	if @treeOrange > 0
  	puts 'You go to count the number of orange on your tree. There are a total of ' + @treeOrange.to_s + ' orange.'
    end
  end

  def pickAnOrange
  	if @treeOrange == 0
  	  puts 'You try to pick an orange BUT here are NOT oranges to pick.'
  	end

  	if @treeOrange > 0
    @treeOrange = @treeOrange - 1
    puts 'You picked an orange, IT WAS DELICIUS!!!'
    end
  end

  def toWater
  	puts 'You go to water your beautiful Orange Tree'

  	if @treeHeight < 150
  	  puts 'You notice your little orange tree is growing very fast! It is ' + @treeHeight.to_s + 'cm height.'
    end
    
    if @treeHeight == 150
      puts 'YOU ARE AMAZED!!! Your loved orange tree produce fruits for the first time!. It is ' + @treeHeight.to_s + 'cm height.'	
    end

    if @treeHeight > 150
      puts 'You realize your orange tree has grown so much that now it gives you a pleasant shadow. It is ' + @treeHeight.to_s + 'cm height.'
    end
    oneYear
  end 	
 
  private

  #def treeDie?
    #@treeYears >= 6
  #end

  def oneYear
    if @treeYears >= 6
      puts 'Another year pass but your loved orange tree is too old and dies naturally...'
      exit
    end

    @treeHeight = @treeHeight + 50
    @treeYears = @treeYears + 1

    if @treeYears < 2
      @treeOrange = 0
    end

    if @treeYears >= 2
      if @treeOrange > 0
        puts 'The time pass and the ' + @treeOrange.to_s + ' oranges left on the tree fall down to the ground.'
        @treeOrange = 0
      end
      @treeOrange = @treeYears + 1
      puts 'A year has pass and the tree keeps growing producing more fruits!.'

    end
  end
end

tree = OrangeTree.new
tree.toWater
tree.countTheOrange
tree.pickAnOrange
tree.toWater
tree.countTheOrange
tree.pickAnOrange
tree.toWater
tree.toWater
tree.toWater
tree.toWater
tree.toWater



