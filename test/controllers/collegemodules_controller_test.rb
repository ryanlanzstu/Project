require "test_helper"

class CollegemodulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @collegemodule = collegemodules(:one)
    sign_in_as(@user)
  end

  test "Should retrieve index page" do
    get collegemodules_url
    assert_response :success
  end

  test "Should retrive new page" do
    get new_collegemodule_url
    assert_response :success
  end

  test "Should create new module" do
    assert_difference("Collegemodule.count") do
      post collegemodules_url, params: { collegemodule: { module_name: "New Module", module_id: "1234", module_lecturer: "Lecturer", user_id: @user.id } }
    end

    assert_redirected_to collegemodule_url(Collegemodule.last)
  end

  test "Should show modules" do
    get collegemodule_url(@collegemodule)
    assert_response :success
  end

  test "Should show edit page" do
    get edit_collegemodule_url(@collegemodule)
    assert_response :success
  end

  test "Should update modules" do
    patch collegemodule_url(@collegemodule), params: { collegemodule: { module_name: "Updated Module" } }
    assert_redirected_to collegemodule_url(@collegemodule)
  end

  test "Should delete module" do
    assert_difference("Collegemodule.count", -1) do
      delete collegemodule_url(@collegemodule)
    end

    assert_redirected_to collegemodules_url
  end

  private

  #Use helper to sign in for authentication
  def sign_in_as(user)
    post user_session_url, params: { user: { email: user.email, password: 'password' } }
    follow_redirect!
  end
end
