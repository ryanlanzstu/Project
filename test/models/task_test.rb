require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @list = lists(:one)
    @task = Task.new(
      name: "Doing Now",
      list: @list,
      user: @user,
      start_date: Date.today
    )
  end

  test "Should work with name, list, user, and start date" do
    assert @task.valid?
  end

  test "Shouldn't work without name" do
    @task.name = nil
    assert_not @task.valid?
  end

  test "Shouldn't work without list" do
    @task.list = nil
    assert_not @task.valid?
  end

  test "Shouldn't work without user" do
    @task.user = nil
    assert_not @task.valid?
  end

  test "Shouldn't work without start date" do
    @task.start_date = nil
    assert @task.valid?
  end
end
