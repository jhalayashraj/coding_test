class Api::V1::BaseController < ApplicationController

	protected

	def authentication_user_with_authentication_token
		@current_user = AuthenticationToken.find_user_from_authentication_token(params[:authentication_token])
		unless @current_user.present?
      render json:({ result: { messages: 'You required to register or login before continue to this action!', rstatus: 0, errorcode: 401 } }.to_json)
    end
	end

	# def render_json(json)
 #    callback = params[:callback]
 #    response = begin
 #      if callback
 #        "#{callback}(#{json});"
 #      else
 #        json
 #      end
 #    end
 #    render(content_type: :js, text: response)
 #  end
end
