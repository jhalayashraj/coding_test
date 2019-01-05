class Api::V1::ListsController < Api::V1::BaseController
	before_action :authentication_user_with_authentication_token
	before_action :require_list, only: [:update, :destroy, :show]

	def index
		@lists = @current_user.lists.all if @current_user.present?
		if @lists.present?
			render json:({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, 
										 data: { messages: @lists } }.to_json)
		else
			render json:({ result: { messages: 'No list found', rstatus: 0, errorcode: 404 } }.to_json)
		end
	end

	def create
		if params[:title].present?
			@list = @current_user.lists.new(list_params)
			if @list.save
				render json:({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, 
										   data: { messages: @list } }.to_json)
			else
				render json:({ result: { messages: @list.errors.full_messages, rstatus: 0, errorcode: 404 } }.to_json)
			end
		else
			render json:({ result: { messages: 'List title is required', rstatus: 0, errorcode: 404 } }.to_json)
		end
	end

	def update
		if params[:title].present?
			@list.update(list_params)
			render json:({ result: { messages: 'ok', rstatus: 1, errorcode: '' }, 
										 data: { messages: @list } }.to_json)
		else
			render json:({ result: { messages: @list.errors.full_messages, rstatus: 0, errorcode: 404 } }.to_json)
		end
	end

	def destroy
		if @list.present?
			@list.destroy
			render json:({ result: { messages: 'List is deleted successfully', rstatus: 0, errorcode: '' },
										 data: { messages: @list } }.to_json)
		else
			render json:({ result: { messages: 'List not found', rstatus: 0, errorcode: 404 } }.to_json)
		end
	end

	def show
	end

	private

	def list_params
		params.require(:list).permit(:id, :user_id, :title)
	end

	def require_list
		@list = List.find_by(id: params[:id])
	end
end
