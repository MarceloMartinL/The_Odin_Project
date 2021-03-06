require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.new(name: "nicholas", email: "nicholas@example.com", password: "qwerty")
  end

  test "name should be present" do
  	@user.name = ""
  	assert_not @user.valid?
  end

  test "email should be present" do 
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "password should be present" do 
  	@user.password = ""
  	assert_not @user.valid?
  end

 	test "should be a valid user" do 
 		assert @user.valid?
 	end
end
