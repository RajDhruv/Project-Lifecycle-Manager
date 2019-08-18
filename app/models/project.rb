class Project < ApplicationRecord
	has_and_belongs_to_many :users
	belongs_to :admin,class_name:"User",foreign_key: :admin
	has_many :tasks

	def self.get_all_user_administered_projects(user, page)
		all_projects=Project.paginate_by_sql("Select * from projects where lock_version<>-1 and admin=#{user.id} order by id desc",:page=>page,:per_page=>10)
		count=Project.find_by_sql("Select count(*) as count from projects where lock_version<>-1 and admin=#{user.id}").last.count
		return all_projects,count
	end

	def self.get_project_tasks_status_data(user, page)
		projects, count= get_all_user_administered_projects(user, page)
		projects_hash=Hash.new
		projects.each do |project|
			tasks=project.tasks
			fresh_task=tasks.select{|x| x if x.status=='fresh'}.length
			ip_task=tasks.select{|x| x if x.status=='in_progress'}.length
			done_tasks=tasks.select{|x| x if x.status=='done'}.length
			projects_hash["#{project.name}"]={"new"=>fresh_task,"in-progress"=>ip_task,"done"=>done_tasks}
		end
		return projects_hash,count
	end

	def get_unmapped_users
		mapped_user_ids=self.users.map(&:id)
		(!mapped_user_ids.nil? and !mapped_user_ids.empty?) ? User.where("id not in (?) and roles='developer'",mapped_user_ids) : User.where("roles='developer'")
	end
end
