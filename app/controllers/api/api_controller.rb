class Api::ApiController < ApplicationController

	before_action :restrict_access, except: [ :info ]

	def info
	end


	private
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
