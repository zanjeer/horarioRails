class Api::ApiController < ApplicationController

	before_action :restrict_access, except: [ :info ]

	def info
		respond "api calls info, token, actions, etc. TODO, Token token='664fbacb8238a3f54d0e8eb643fde9ce'"
	end


	private
		def respond(response)
		 	respond_to do |format|
		      format.json { render json: response }
		    end
		end

		def restrict_access
		  authenticate_or_request_with_http_token do |token, options|
		    ApiKey.exists?(access_token: token)
		  end
		end

		# def restrict_access
		#   api_key = ApiKey.find_by_access_token(params[:access_token])
		#   head :unauthorized unless api_key
		# end

end
