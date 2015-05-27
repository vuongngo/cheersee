class FriendhashesController < ApplicationController
	before_action :sign_in?
	# Create secret token and share to friends to join friendship

	def search
	end
	
	def new
		@friendhash = Friendhash.new
	end

	def create
		@friendhash = current_user.friendhashes.build(token_params)
		if @friendhash.save
			flash.now[:success] = "Congrats! Your friends are now ready to connect with you by your 'secret whisper' ;) "
		else 
			flash.now[:alert] = "This secret word is taken! Please try another one!"
		end

		refresh_friendlist_of_header
        clear_message_notification
	end

	def destroy
		@friendhash = current_user.friendhashes
		t = Time.zone.now
		@friendhash.each do |f|
			if t >= (f.created_at + 12.hours)
				t.destroy
			end
		end

	end

	private
		def token_params
			get_lat_lng(params[:friendhash][:lat], params[:friendhash][:lng])
			update_location(@lat, @long)
			Time.zone = @timezone.active_support_time_zone
			params[:friendhash][:expired_at] = Time.zone.now + 24.hours
			params.require(:friendhash).permit(:token, :expired_at,  :lat, :lng)
		end
end
