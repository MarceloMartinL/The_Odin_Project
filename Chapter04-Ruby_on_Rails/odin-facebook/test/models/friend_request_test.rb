require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase

	def setup
	  @michael = users(:michael)
	  @archer = users(:archer)
	  @lana = users(:lana)
	  @friend_request = @michael.friend_requests.new(friend: @archer)
	end

	test "user id should be present" do
		@friend_request.user_id = nil
		assert_not @friend_request.valid?
	end

	test "friend id should be present" do
		@friend_request.friend_id = nil
		assert_not @friend_request.valid?
	end

	test "should be valid" do
		assert @friend_request.valid?
  	assert_equal @friend_request.user, @michael
  	assert_equal @friend_request.friend, @archer
  end

  test "the users cant be already friends" do
  	@michael.friends << @archer
  	assert_not @friend_request.valid?
  end

  test "the friend request shouldn't already exist" do 
  	@friend_request.save
  	@friend_request2 = @michael.friend_requests.new(friend: @archer)
  	assert_not @friend_request2.valid?
  end

  test "the user and the friend can't be the same" do
  	@friend_request3 = @michael.friend_requests.new(friend: @michael)
  	assert_not @friend_request3.valid?
  end

  test "should create a friendship between users" do 
  	@friend_request.accept
  	assert @michael.friends.include?(@archer)
  	assert @archer.friends.include?(@michael)
  end

end
