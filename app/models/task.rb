class Task < ApplicationRecord
  belongs_to :user , required: false
  belongs_to :project
  enum status:{fresh:0 ,in_progress:1 ,done:2 }
  scope :fresh_tasks, -> {where('status=0')}

  def self.create_tasks(project,data_string)
  	datas=data_string.split('~@@@~')
  	datas.each do|data|
  		ActiveRecord::Base.lock_optimistically=false
  		Task.create(description:data, lock_version:1, project: project, status:0)
  		ActiveRecord::Base.lock_optimistically=true
  	end
  end

	def self.get_developer_tasks_status_data(user)
		user_tasks=user.tasks
		tasks_count=Hash.new
		tasks_count["new"]=user_tasks.select{|x| x if x.status=='fresh'}.length
		tasks_count["in-progress"]=user_tasks.select{|x| x if x.status=='in_progress'}.length
		tasks_count["done"]=user_tasks.select{|x| x if x.status=='done'}.length
		return tasks_count
	end

	def self.user_tasks_projects_details(user, status)
		user.tasks.where(status: status.to_sym).includes(:project)
	end
end
