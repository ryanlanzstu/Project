require "test_helper"

class TasksSecurityTest < ActionDispatch::IntegrationTest
  #Use helper to sign in for authentication
  def sign_in_as(user)
    post user_session_url, params: { user: { email: user.email, password: 'password' } }
    follow_redirect!
  end

  setup do
    @user = users(:one)
    @other_user = users(:two)
    @task = tasks(:one) #Only for user
  end

  test "Shows index when signed in" do
    sign_in_as(@user)
    get tasks_url
    assert_response :success
  end

  test "Redirect to login page if not logged in" do
    get tasks_url
    assert_redirected_to new_user_session_url #Redirects to login
  end

  test "Allow access to signed in user's task" do
    sign_in_as(@user)
    get task_url(@task)
    assert_response :success
  end

  test "Shouldn't allow access to other users tasks" do
    sign_in_as(@other_user)
    assert_raises(ActiveRecord::RecordNotFound) do
      get task_url(@task)
    end
  end
end
