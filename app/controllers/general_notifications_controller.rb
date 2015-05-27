class GeneralNotificationsController < ApplicationController
	before_action :sign_in?
	
	def index
	  clear_general_notification_count
	  @general_notifications = current_user.general_notifications.includes({sender: :profile}, :set_challenge, :join_challenge, :reference)
	  @general_notifications = Kaminari.paginate_array(@general_notifications).page(params[:page]).per(10)
	end
end
