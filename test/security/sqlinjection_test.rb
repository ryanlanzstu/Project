require "test_helper"

class AuthenticationSecurityTest < ActionDispatch::IntegrationTest
  # Use helper to sign in
  def sign_in_as(user, password)
    post user_session_url, params: { user: { email: user.email, password: password } }
  end

  setup do
    @user = users(:one)
  end

  test "login should be protected from SQL injection" do
    # Attempt SQL injection through email field
    post user_session_url, params: { user: { email: "' OR '1'='1", password: "password" } }
    assert_response :unprocessable_entity

    # Attempt SQL injection through password field
    post user_session_url, params: { user: { email: @user.email, password: "' OR '1'='1" } }
    assert_response :unprocessable_entity
  end
end
