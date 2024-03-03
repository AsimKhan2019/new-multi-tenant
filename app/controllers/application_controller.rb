class ApplicationController < ActionController::Base
	set_current_tenant_through_filter
	before_action :require_authentication
	before_action :set_tenant

	def require_authentication
		current_user || redirect_to(new_session_path)
	end 

	def current_user
		@current_user ||= if session[:user_id].present? 
			User.find(session[:user_id])
		end 
	end 

	def current_account 
		@current_account ||= current_user.try(:account)
	end 

	def set_tenant 
		set_current_tenant(current_account) 
	end 
end
