class TasksController < ApplicationController
  before_action :set_project, only:[:task_allocation_list]
  before_action :set_task, only:[:allocate_task_to_developer, :update_task_status]

  def task_allocation_list
  	@tasks=@project.tasks.fresh_tasks
  	@developers=@project.users
  	render partial: 'tasks_redirection.js.erb', locals:{from: :task_allocation_list}
  end

  def allocate_task_to_developer
  	@task.update_attribute('user_id',params[:user_id])
  	render nothing: true
  end

  def get_user_task_details
  	@tasks=Task.user_tasks_projects_details(current_user, params[:status])
  	@status=(params[:status]=="fresh") ? "New" : ((params[:status]=="in_progress") ? "In-Progress" : "Completed")
  	render partial: 'tasks_redirection.js.erb', locals:{from: :get_user_task_details}
  end

  def update_task_status
    @task.update_attribute("status", params[:status].to_sym)
    render nothing: true
  end

  private

  def set_project
  	@project=Project.find_by_id params[:id]
  end

  def set_task
  	@task=Task.find_by_id params[:task_id]
  end
end
