require "test_helper"

class CollegemoduleTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @collegemodule = Collegemodule.new(
      user: @user
    )
  end

  test "Should be valid with a user" do
    assert @collegemodule.valid?
  end

  test "Shouldn't be valid without a user" do
    @collegemodule.user = nil
    assert_not @collegemodule.valid?
  end
end
