require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "test that user enters first name" do
  	user = User.new

  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "test that user enters last name" do
  	user = User.new

  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "test that user enters profile name" do
  	user = User.new

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:Wali).profile_name
    
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Wali', last_name: 'Ali', email: 'abdishwak@gmail.com')
    user.password = user.password_confirmation = 'password'

    user.profile_name = 'waliali_1'
    assert user.valid?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: "Wali", last_name: "Ali", email: "abdishwak@gmail.com")
    user.password = user.password_confirmation = "password"
   
  	user.profile_name = "My Profile with spaces"
  	assert !user.save #make sure it's not saved
  	assert !user.errors{:profile_name}.empty? # make sure error message is not empty
  	assert user.errors[:profile_name].include?("Must be formatted correctly")

  end
end
