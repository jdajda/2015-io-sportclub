module SessionHelper

	def log_in(user)
	    session[:user_id] = user.id
	end

	def current_user
		if session.has_key?(:user_id)
			@current_user ||= User.find_by(id: session[:user_id])
		else
			@current_user = nil
		end
	end

	def logged_in?
	  !current_user.nil?
	end

	def log_out
		session.delete(:user_id)
	end
end
