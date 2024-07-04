require "test_helper"

class CollegemodulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @collegemodule = collegemodules(:one)
  end

  test "should get index" do
    get collegemodules_url
    assert_response :success
  end

  test "should get new" do
    get new_collegemodule_url
    assert_response :success
  end

  test "should create collegemodule" do
    assert_difference("Collegemodule.count") do
      post collegemodules_url, params: { collegemodule: {  } }
    end

    assert_redirected_to collegemodule_url(Collegemodule.last)
  end

  test "should show collegemodule" do
    get collegemodule_url(@collegemodule)
    assert_response :success
  end

  test "should get edit" do
    get edit_collegemodule_url(@collegemodule)
    assert_response :success
  end

  test "should update collegemodule" do
    patch collegemodule_url(@collegemodule), params: { collegemodule: {  } }
    assert_redirected_to collegemodule_url(@collegemodule)
  end

  test "should destroy collegemodule" do
    assert_difference("Collegemodule.count", -1) do
      delete collegemodule_url(@collegemodule)
    end

    assert_redirected_to collegemodules_url
  end
end
