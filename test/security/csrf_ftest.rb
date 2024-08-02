require "test_helper"

class CsrfProtectionTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)
  end

  test "should protect from CSRF attack" do
    #Logout without CSRF
    assert_raises(ActionController::InvalidAuthenticityToken) do
      delete destroy_user_session_url, headers: { "X-CSRF-Token" => "" }
    end
  end

  #Use helper to sign in for authentication
  def sign_in_as(user)
    post user_session_url, params: { user: { email: user.email, password: 'password' } }
    follow_redirect!
  end
end
