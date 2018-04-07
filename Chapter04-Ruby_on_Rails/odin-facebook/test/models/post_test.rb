require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  test "order should be most recent first" do 
  	assert_equal posts(:most_recent), Post.first
  end
end
