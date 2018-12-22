class Api::V1::RegistrationsController < ApplicationController

	def create
		if params[:email].present? && params[:password].present?
			user = User.create(email: params[:email], password: params[:password], username: params[:username])
			if user.valid?
				user.authentication_tokens.create(auth_token: AuthenticationToken.generate_unique_token)
				render json:({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, 
										   data: { messages: 'User Created Successfully!' } }.to_json)
			else
				render json:({ result: { messages: user.errors.full_messages, rstatus: 0, errorcode: 409 } }.to_json)
			end
		else
			render json:({ result: { messages: 'Email and Password Required', rstatus: 0, errorcode: 400 } }.to_json)
		end
	end

end
