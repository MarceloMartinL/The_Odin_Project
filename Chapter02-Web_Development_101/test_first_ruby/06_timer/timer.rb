class Timer
  #write your code here
  def initialize
  	@time = Time.new (2017)
  	@seconds = @time.sec
  end

  def seconds= (num)
  	@seconds = num
  end 

  def seconds
  	@seconds
  end

  def time_string
  	@adition = @time + @seconds
  	@time_string = @adition.strftime "%H:%M:%S"
  	
  end
end
