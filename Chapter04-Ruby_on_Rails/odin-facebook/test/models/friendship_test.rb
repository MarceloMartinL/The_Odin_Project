require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  def setup
	  @michael = users(:michael)
	  @archer = users(:archer)
	end

	test "should create the inverse relationship" do
		@michael.friends << @archer
		assert @archer.friends.include?(@michael) 
	end

	test "should destroy the inverse relationship" do
		@michael.friends << @archer
		@archer.friends.destroy(@michael)
		assert_not @michael.friends.include?(@archer)
	end

	test "a user can't friendship himself" do
		friendship = Friendship.new(user: @michael, friend: @michael)
		assert_not friendship.valid?
	end
end
