require "test_helper"

class ListTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @list = List.new(
      name: "Doing Now",
      user: @user
    )
  end

  test "Should work with name and user" do
    assert @list.valid?
  end

  test "Shouldn't work without name" do
    @list.name = nil
    assert_not @list.valid?
  end

  test "Shouldn't work withou user" do
    @list.user = nil
    assert_not @list.valid?
  end
end
