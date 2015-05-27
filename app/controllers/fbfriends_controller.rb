class FbfriendsController < ApplicationController
	# Invite friends using Facebook
	def index
	end

	def create
	  users = Identity.where(user_id: current_user.id).last
	  me = FbGraph2::User.me(users.token)
	  me.feed!(
	    :message => 'Testing fb_graph',
	    :picture => 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTT3GRN7Rpu1J8kaqslgURGSIMyRpPrKhBCtRhCgJKHvIyoHuHhvNl-Ne-N',
	    :link => 'http://www.npr.org/blogs/pictureshow/',
	    :name => 'Testing',
	    :description => 'A Ruby wrapper for Facebook Graph API'
	  )
	  redirect_to root_path
	end
end
