require "test_helper"

class ListsSecurityTest < ActionDispatch::IntegrationTest
  #Use helper to sign in for authentication
  def sign_in_as(user)
    post user_session_url, params: { user: { email: user.email, password: 'password' } }
    follow_redirect!
  end

  setup do
    @user = users(:one)
    @other_user = users(:two)
    @list = lists(:one) # This should be owned by @user
  end

  test "Shows index when signed in" do
    sign_in_as(@user)
    get lists_url
    assert_response :success
  end

  test "Redirect to login page if not logged" do
    get lists_url
    assert_redirected_to new_user_session_url # Ensure redirection to login
  end

  test "Allow access to signed in user's list" do
    sign_in_as(@user)
    get list_url(@list)
    assert_response :success
  end

  test "Block access to other user's list" do
    sign_in_as(@other_user)
    assert_raises(ActiveRecord::RecordNotFound) do
      get list_url(@list)
    end
  end
end
