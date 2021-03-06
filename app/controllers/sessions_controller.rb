class SessionsController < ApplicationController
	def create		
		#raise request.env["omniauth.auth"].to_yaml
		auth = request.env['omniauth.auth']
		user = Users.find_by_provider_and_uid(auth['provider'], auth['uid']) || Users.create_with_omniauth(auth)
		session[:user_id] = user.id
		redirect_to root_url, notice: 'Signed in!'
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, notice: 'offline in!'
	end
end
