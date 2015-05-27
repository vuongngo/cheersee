class ReputationsController < ApplicationController
	before_action :sign_in?
	
	def show
		@rep = current_user.reputation
	end
end
