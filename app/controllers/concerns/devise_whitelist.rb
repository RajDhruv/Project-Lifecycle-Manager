module DeviseWhitelist
	extend ActiveSupport::Concern
	included do 
		before_action :configure_params, if: :devise_controller?
	end
	
	def configure_params
		added_attrs = [:name, :email, :password, :password_confirmation, :roles, :remember_me]
		devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
		devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	end
end