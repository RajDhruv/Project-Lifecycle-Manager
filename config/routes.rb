Rails.application.routes.draw do
  root 'home#home_page'
  get 'home/home_page'

  resources :home do
  	collection do
  		get 'home_page'
  	end 
  end

  resources :projects do
  	collection do
  		get 'new'
  		post 'create'
  		get 'edit'
  		put 'update'
  		post 'delete'
  		get 'manage_projects'
  		get 'add_tasks'
  		post 'create_tasks'
  		get 'unmapped_developers'
  		post 'map_developers'
  	end 
  end

  resources :tasks do
  	collection do
  		get 'task_allocation_list'
  		post 'allocate_task_to_developer'
  		get 'get_user_task_details'
      post 'update_task_status'
  	end 
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
