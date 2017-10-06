def stock_picker (priceArray)
  
  price_list = priceArray.clone
  price_listb = priceArray.clone
  best_trade = []
  max = price_list.max
  max_lb = price_listb.max
  min = price_list.min
  min_lb = price_listb.min
  max_index = price_list.index(max)
  max_index_lb = price_listb.index(max_lb)
  min_index = price_list.index(min)
  min_index_lb = price_listb.index(min_lb)
  i = 0

    if max_index > min_index
  	  best_trade.push(min_index)
  	  best_trade.push(max_index) 	

    else

    
      while min_index > max_index  
  	    price_list.delete_at(min_index)
        min = price_list.min
        min_index = price_list.index(min)
        max_a = price_list[max_index]
        min_a = price_list[min_index]
        dif_a = max_a - min_a
  	  end

      while min_index_lb > max_index_lb
      
        price_listb.delete_at(max_index_lb)
        max_lb = price_listb.max
        min_lb = price_listb.min
        max_index_lb = price_listb.index(max_lb)
        min_index_lb = price_listb.index(min_lb)
        puts price_listb
        puts max_index_lb
        max_b = price_listb[max_index_lb]
        min_b = price_listb[min_index_lb]
        puts max_b
        puts min_b
        dif_b = max_b - min_b
        i += 1
      end

      if dif_a > dif_b
        best_trade.push(min_index)
        best_trade.push(max_index)

      else
        best_trade.push(min_index_lb + i)
        best_trade.push(max_index_lb + i)
      end

    end
  puts "best deal days: #{best_trade}"
end
stock_picker([8,3,4,6,3,5,9,6,7])
