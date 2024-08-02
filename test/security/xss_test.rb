require "test_helper"

class XssProtectionTest < ActionDispatch::IntegrationTest
  # Use helper to sign in
  def sign_in_as(user)
    post user_session_url, params: { user: { email: user.email, password: 'password' } }
    follow_redirect!
  end

  setup do
    @user = users(:one)
  end

  test "should escape HTML in login form input" do
    # Attempt to login with an XSS payload in the email
    post user_session_url, params: { user: { email: "<script>alert('XSS');</script>", password: 'password' } }

    # Check for response code 200 to ensure it's a valid page view and not a redirect or error
    assert_response :success

    # Check that the input is properly escaped in the response
    # Assuming the login form will re-render with the user's input on failure
    assert_no_match /<script>alert\('XSS'\);<\/script>/, response.body
    assert_match /&lt;script&gt;alert\(&#39;XSS&#39;\);&lt;\/script&gt;/, response.body
  end
end
