class FriendshipsController < ApplicationController
	before_action :sign_in?
	# Friend request & deny
	
	# Show friendlist
	def show
		@friendship1 = current_user.friendships.includes(:friend).where(accepted: true) 
		@friendship2 = current_user.inverse_friendships.includes(:user).where(accepted: true)
	end

	# Friend request
	def create
	  @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
	  if @friendship.save
	    flash[:success] = "Friend request sent! Stay tunned!"
	  else
	    flash.now[:alert] = "Unable to add friend :("
	  end
	  	update_message_notification(params[:friend_id])
		refresh_friendlist_of_header
		clear_message_notification
		redirect_to :back
	    rescue ActionController::RedirectBackError
	      redirect_to root_path
 	end

	# Friend accept
	def update
		@friendship = Friendship.where("friend_id = ? AND user_id = ?", current_user.id, params[:friend_id]).take
		if params[:accept] == "true"
			@friendship.update(accepted: true)
		else
			@friendship.destroy
		end
		update_message_notification(params[:friend_id])
		refresh_friendlist_of_header
		clear_message_notification
	
	end

	# Unfriend
	def destroy
	  @friendship = current_user.friendships.where(friend_id: params[:friend_id]).take
	  if @friendship.nil?
	  	@friendship = current_user.inverse_friendships.where(user_id: params[:user_id]).take
	  end
	  if @friendship.destroy
	  	flash.now[:notice] = "Removed friendship."
	  end
	  refresh_friendlist_of_header  
	  clear_message_notification
	end

	def show_friend_list
	    @fr_id = params[:fr_id]
	end

end
