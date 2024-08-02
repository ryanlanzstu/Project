require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should work with email & password" do
    user = User.new(email: 'test@test.com', password: 'password')
    assert user.valid?
  end

  test "shouldn't work with no email" do
    user = User.new(email: nil, password: 'password')
    assert_not user.valid?
  end

  test "shouldn't work with no password" do
    user = User.new(email: 'test@test.com', password: nil)
    assert_not user.valid?
  end
end
