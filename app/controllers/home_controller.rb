class HomeController < ApplicationController

  def home_page
  	params[:page]||=1
  	@page=params[:page]
  	if logged_in?(:admin)
  		@projects, @count=Project.get_project_tasks_status_data(current_user,@page)
  	else
  		@statuses=Task.get_developer_tasks_status_data(current_user)
  	end
  	respond_to do |format|
  		format.js{render partial:"home.js.erb"}
  		format.html{render template:"home/home_page.html.erb"}
  	end
  end
end
