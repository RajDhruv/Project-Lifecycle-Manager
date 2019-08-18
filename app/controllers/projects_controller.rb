class ProjectsController < ApplicationController
	before_action :set_project, only:[:add_tasks, :create_tasks, :unmapped_developers, :map_developers]
  def new
  	@project=Project.new
    render partial: 'project_redirection.js.erb', locals:{from: :new}
  end

  def edit
  end

  def create
  	@project=Project.new(project_params)
    @project.admin=current_user
    @project.lock_version=1
    @project.developer_count=0
    @project.save
    manage_projects
  end

  def update
  end

  def delete
  end

  def manage_projects
  	params[:page]||=1
  	@page=params[:page]
  	@projects, @count=Project.get_all_user_administered_projects(current_user, @page)
  	render partial: 'project_redirection.js.erb', locals:{from: :manage_projects}
  end

  def add_tasks
  	@tasks=@project.tasks
  	render partial: 'project_redirection.js.erb', locals:{from: :add_tasks}
  end

  def create_tasks
  	Task.create_tasks(@project,params[:data_string])
  	manage_projects
  end

  def unmapped_developers
  	@unmapped_users=@project.get_unmapped_users
  	render partial: 'project_redirection.js.erb', locals:{from: :unmapped_developers}
  end

  def map_developers
  	@user=User.find_by_id params[:user_id]
  	@project.users<< @user
  	@project.update_attribute('developer_count',(@project.developer_count.nil? ? 1 : @project.developer_count+1))
  	render partial: 'project_redirection.js.erb', locals:{from: :map_developers}
  end

  private

  def set_project
  	@project=Project.find_by_id params[:id]
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end