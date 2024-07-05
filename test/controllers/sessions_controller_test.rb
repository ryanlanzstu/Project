require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: 'testuser@example.com', password: 'password', password_confirmation: 'password')
  end

  test "user logs in successfully" do
    post user_session_path, params: { user: { email: @user.email, password: 'password' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "nav", "Logout"
  end

  test "wrong password user doesn't log in" do
    post user_session_path, params: { user: { email: @user.email, password: 'wrongpassword' } }
    assert_response :success
    assert_select "div#error_explanation"
  end
end
