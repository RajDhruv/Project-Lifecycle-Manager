require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get task_allocation_list" do
    get tasks_task_allocation_list_url
    assert_response :success
  end

end
