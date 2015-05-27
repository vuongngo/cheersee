class ActivitiesController < ApplicationController
	before_action :sign_in?
	# Static controller for create, edit & join challenges

	# activities_path
	def index
		# Get all challenges shared by users which end_time > current_time
		Time.zone = current_user.location.user_time_zone if current_user.location.present?
		@get_challenges = SetChallenge.includes({user: :profile}, {set_challenge_comments: :user}, :set_challenge_favs).where("end_time > ?", Time.zone.now)
		@get_challenges = Kaminari.paginate_array(@get_challenges).page(params[:page])
		if @get_challenges.count == 0 && current_user.profile.gender == "Male"
			flash.now[:warning] = "We are sorry. There is no contest at the moment!"
		end
		# Create new challenge form
		@set_challenge = current_user.set_challenges.new if current_user.profile.gender == "Female"
		# View all challenge created by this user
		@my_challenge = SetChallenge.where("user_id = ? AND end_time > ?", current_user.id, Time.zone.now) if current_user.profile.gender == "Female"
		if @my_challenge.count == 0
			flash.now[:warning] = "You don't have any challenge at the moment. Create one have have great date with cool man in town!"
		end
		# Comment to challenges
		@set_challenge_comment = current_user.set_challenge_comments.new

		respond_to do |format|
	      format.html
	      format.js
	    end
	end

	def favorite
		@cid = params[:challenge]
		set_challenge_fav = current_user.set_challenge_favs.build(set_challenge_id: @cid)
		set_challenge = SetChallenge.includes(:user).find(@cid)
		@fav = set_challenge.no_of_fav + 1
		if set_challenge_fav.save!
			if set_challenge.update(no_of_fav: @fav)
				if set_challenge.user_id != current_user.id
					GeneralNotification.create!(user_id: set_challenge.user_id, sender_id: current_user.id, set_challenge_id: set_challenge.id, mes: current_user.name + " favorited your '" + set_challenge.post + "' post")
					update_general_notification_count(set_challenge.user_id)
					creat_or_update_potential_rel(set_challenge.user_id, current_user.id, 1, 0, 0)
				end
			else
				flash.now[:warning] = "You've already favorited this challenge!"
		    end
		end
		respond_to do |format|
	      format.html
	      format.js
	    end

	end
end
