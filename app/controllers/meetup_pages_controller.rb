class MeetupPagesController < ApplicationController
	before_action :sign_in?
	# Controller for accept hangout request, message before hangout

	def new
		@request_hangout = RequestHangout.new
		# Show request hangout
		if current_user.location.present?
			Time.zone = current_user.location.user_time_zone 
			t = Time.zone.now
		end
		@date_invite = current_user.share_hangout_mates.includes({share_hangout: :user}).where("share_hangouts.share_time > ?", t)
		@request = RequestHangout.joins(:share_hangout, {user: :profile}, {user: :reputation}).where("share_hangouts.user_id = ?", current_user.id)
        @friend_meetup1 = current_user.friendships.includes({friend: :profile}, {friend: :share_hangouts}).where("accepted = true AND share_hangouts.notify_friend = true AND share_hangouts.share_time > ?", t) 
        @friend_meetup2 = current_user.inverse_friendships.includes({user: :profile}, {user: :share_hangouts}).where("accepted = true AND share_hangouts.notify_friend = true AND share_hangouts.share_time > ?", t)  

        if @request.count == 0 && @friend_meetup1.count == 0 && @friend_meetup2.count == 0
        	flash.now[:warning] = "Are you bored? Create your own meetup and start a date now."
        end
		# If hangout time passed, show reference form for user to fill
		Time.zone = current_user.location.user_time_zone
		current_time = Time.zone.now
		@ref = Reference.includes(:receiver).joins(:hangout).where("user_id = ? AND hangouts.share_time <= ? AND feed = false ", current_user.id, current_time)
		if @ref.count != 0
			flash.now[:warning] = "You have a peer-review form waiting to be filled."
		end
		HangoutNotification.find_by(user_id: current_user.id).update(unread_count: 0)
		respond_to do |format|
      		format.html
      		format.js
      	end
	end

	# If request is denied, delete RequestHangout table
	def no
		id = params[:id]
    	RequestHangout.destroy(id)
    	flash.now[:warning] = "Request denied!"
    	@request = RequestHangout.joins(:share_hangout, :user).where("share_hangouts.user_id = ?", current_user.id)
    	if current_user.location.present?
			Time.zone = current_user.location.user_time_zone 
			t = Time.zone.now
		end

		@date_invite = current_user.share_hangout_mates.includes({share_hangout: :user}).where("share_hangouts.share_time > ?", t)
	end
	# No to invite
	def invite_no
		id = params[:id]
    	ShareHangoutMate.destroy(id)
    	flash.now[:warning] = "Invitation denied!"
		if current_user.location.present?
			Time.zone = current_user.location.user_time_zone 
			t = Time.zone.now
		end
    	@request = RequestHangout.joins(:share_hangout, :user).where("share_hangouts.user_id = ?", current_user.id)
		@date_invite = current_user.share_hangout_mates.includes({share_hangout: :user}).where("share_hangouts.share_time > ?", t)    	
	end

	# If request is created
	def yes
		# Remove Request from table RequestHangout
		if params[:id].present?
			id = params[:id]
			RequestHangout.destroy(id)
		end
		# Remove Share from table ShareHangout
		shareid = params[:sid]
		ShareHangout.destroy(shareid)
		# Create Hangout in table Hangout
		h = Hangout.create(hangout_params)
		# Create relationship people who hangout in table WhoHangout
		uid = params[:user_id]	
		hid = h.id
		WhoHangout.create!(hangout_id: hid, user_id: uid)
		WhoHangout.create!(hangout_id: hid, user_id: current_user.id)
		Reference.create!(user_id: current_user.id, receiver_id: uid, hangout_id: hid)
		Reference.create!(user_id: uid, receiver_id: current_user.id, hangout_id: hid)

		update_hangout_notification(uid)

		flash.now[:success] = "Meetup created!"
		if current_user.location.present?
			Time.zone = current_user.location.user_time_zone 
			t = Time.zone.now
		end
		@request = RequestHangout.joins(:share_hangout, :user).where("share_hangouts.user_id = ?", current_user.id)
		@meetup = Hangout.includes({hangout_messages: :user}, :who_hangouts).where("who_hangouts.user_id = ?", current_user.id)
		@date_invite = current_user.share_hangout_mates.includes({share_hangout: :user}).where("share_hangouts.share_time > ?", t)
	end

	# Handle map
	def map
		if map_params[:ulatitude].nil?
			user_location = Location.where(user_id: current_user.id).take
			@locale = [user_location.latitude, user_location.longitude, map_params[:latitude], map_params[:longitude]]
		else
			@locale = [map_params[:ulatitude], map_params[:ulongitude], map_params[:latitude], map_params[:longitude]]
		end
	end

	# Handle references
	def ref
		rid = ref_params[:reference_id]
		Reference.find(rid).update(feed: true)
		t = feed_params[:time_management_id]
		if t == "3" # If user doesn't turn up the meetup
			Feedback.create!(feed_params_two)
		else 
			Feedback.create!(feed_params)
		end
		current_time = Time.zone.now
		@ref = Reference.includes(:receiver).joins(:hangout).where("user_id = ? AND hangouts.share_time <= ? AND feed = false ", current_user.id, current_time)
		# Calculate the overall reputation
		receiver = Reference.find(rid).receiver_id
		@rep = Reputation.where(user_id: receiver).take
			if t == "3"
				@rep.never_come = @rep.never_come + 1
				@rep.save
			else
				if t == "1"
					@rep.time_early = @rep.time_early + 1
				else t == "2"
					@rep.time_late = @rep.time_late + 1
				end
					a = @rep.number_of_rate.to_f
					@rep.number_of_rate = @rep.number_of_rate + 1
					b = @rep.number_of_rate.to_f

					@rep.rate_av = (@rep.rate_av.to_f * a + feed_params[:rate].to_f) / b
					@rep.friendly_av = (@rep.friendly_av.to_f * a + feed_params[:friendly].to_f) / b		
					@rep.fun_av = (@rep.fun_av.to_f * a + feed_params[:fun].to_f) / b		
					@rep.confidence_av = (@rep.confidence_av.to_f * a + feed_params[:confidence].to_f) / b		
					@rep.curiosity_av = (@rep.curiosity_av.to_f * a + feed_params[:curiosity].to_f) / b	

					@rep.save					
			end
		@ref = Reference.includes(:receiver).joins(:hangout).where("user_id = ? AND hangouts.share_time <= ? AND feed = false ", current_user.id, current_time)
		GeneralNotification.create!(user_id: receiver, sender_id: current_user.id, reference_id: rid, mes: current_user.name + " gave you a feedback after meetup!")
		update_general_notification_count(receiver)
		flash.now[:success] = "Thank you! We really appreciate your feedback!"

	end

	private

		def hangout_params
			params.permit(:business_name, :business_location, :longitude, :latitude, :share_time)
		end

		def map_params
			params.permit(:ulatitude, :ulongitude, :latitude, :longitude)
		end

		def ref_params
			params.permit(:reference_id)
		end

		def feed_params
			params.permit(:reference_id, :time_management_id, :rate, :friendly, :fun, :confidence, :curiosity, :comment)
		end

		def feed_params_two
			params.permit(:reference_id, :time_management_id)
		end

end
