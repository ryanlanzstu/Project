require "test_helper"

class CollegemodulesSecurityTest < ActionDispatch::IntegrationTest
  # Use helper to sign in
  def sign_in_as(user)
    post user_session_url, params: { user: { email: user.email, password: 'password' } }
    follow_redirect!
  end

  setup do
    @user = users(:one)
    @other_user = users(:two)
    @collegemodule = collegemodules(:one) # This should be owned by @user
  end

  test "Shows index when signed in" do
    sign_in_as(@user)
    get collegemodules_url
    assert_response :success
  end

  test "Redirect to login page if not logged" do
    get collegemodules_url
    assert_redirected_to new_user_session_url # Ensure redirection to login
  end

  test "Allow access to signed in users modules" do
    sign_in_as(@user)
    get collegemodule_url(@collegemodule)
    assert_response :success
  end

  test "Block access to other users modules" do
    sign_in_as(@other_user)
    assert_raises(ActiveRecord::RecordNotFound) do
      get collegemodule_url(@collegemodule)
    end
  end

end
