require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should create a user" do
    user = User.new(email: 'testuser@example.com', password: 'password', password_confirmation: 'password')
    assert user.save, "User was not saved"
  end
end
