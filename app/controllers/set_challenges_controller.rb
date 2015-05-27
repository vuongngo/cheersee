class SetChallengesController < ApplicationController
	before_action :sign_in?
	before_action :correct_user, only: :destroy

	# Show all challenges
	def index
		@set_challenges = SetChallenge.includes(:user, {set_challenge_comments: :user}, :set_challenge_favs).where("created_at > ? AND end_time > ?", Time.at(params[:after].to_i + 1, Time.zone.now))
		@set_challenge_comment = current_user.set_challenge_comments.new
	end

	# Show form to create new challenge
	def new
		@set_challenge = current_user.set_challenges.new
	end

	# Create new challenge
	def create
		get_lat_lng(set_challenge_params[:latitude], set_challenge_params[:longitude])
		update_location(@lat, @long)
		@set_challenge = current_user.set_challenges.build(set_challenge_params)
		if @set_challenge.save
			flash.now[:success] = "Challenge create! Enjoy it :)"
		else
			flash.now[:danger] = "Please fill the missing field!"
		end
		@set_challenges = @set_challenge
		@my_challenge = SetChallenge.where(user_id: current_user.id)
		@set_challenge_comment = current_user.set_challenge_comments.new
		@get_challenges = SetChallenge.includes({user: :profile}, {set_challenge_comments: :user}, :set_challenge_favs).where("end_time > ?", Time.zone.now)
		@get_challenges = Kaminari.paginate_array(@get_challenges).page(params[:page])
	end

	# Edit challenge form
	def edit
		@set_challenge = current_user.set_challenges.joins(:leaderboard_challenge).find(params[:set_challenge_id])
		@my_challenge = SetChallenge.where(user_id: current_user.id)
	end

	# Update challenge
	def update
		@set_challenge = current_user.set_challenges.find(params[:id])
		@leaderboard_challenge = @set_challenge.leaderboard_challenge
		if @set_challenge.update_attributes(update_challenge_params) && @leaderboard_challenge.update_attributes(update_leaderboard_params)
			flash.now[:success] = "Challenge updated! Enjoy it :)"
		else
			flash.now[:danger] = "Please fill the missing field!"
		end
		Time.zone = current_user.location.user_time_zone
		@set_challenges = SetChallenge.includes(:user, {set_challenge_comments: :user}, :set_challenge_favs).where("end_time > ?", Time.zone.now)
		@set_challenge_comment = current_user.set_challenge_comments.new
	end

	# Show challenge created by user
	def show
		Time.zone = current_user.location.user_time_zone
		@my_challenge = current_user.set_challenges.where("end_time > ?", Time.zone.now)
	end

	def destroy
		@set_challenge.destroy
		flash[:success] = "Successfully removed!"
		redirect_to activities_path
	end

	private
		def set_challenge_params
			if params[:set_challenge][:latitude].nil?
				locale = current_user.location
				params[:set_challenge][:latitude] = locale.latitude
				params[:set_challenge][:longitude] = locale.longitude
			end
			if current_user.location.present?
				Time.zone = current_user.location.user_time_zone
			else 
				timezone = Timezone::Zone.new :latlon => [params[:set_challenge][:latitude], params[:set_challenge][:longitude]]
    			Time.zone = timezone.active_support_time_zone
    			Location.create!(user_id: current_user.id, latitude: params[:set_challenge][:latitude], longitude: params[:set_challenge][:longitude], user_time_zone: timezone.active_support_time_zone)
    		end
    		params[:set_challenge][:end_time] = Time.zone.now + params[:set_challenge][:time_span].to_i.days
			params.require(:set_challenge).permit(:post, :time_span, :point_metric, :point_measure, :latitude, :longitude, :setchallenge, :remote_setchallenge_url, :no_of_fav, :end_time)
    	end

    	def update_challenge_params
    		set_challenge = current_user.set_challenges.find(params[:id])
    		if set_challenge.time_span != params[:set_challenge][:time_span]
    			params[:set_challenge][:end_time] = set_challenge.created_at + params[:set_challenge][:time_span].to_i.days
    		else
    			params[:set_challenge][:end_time] = set_challenge.end_time
    		end
    		params.require(:set_challenge).permit(:post, :time_span, :point_metric, :point_measure, :setchallenge, :end_time)
    	end

    	def update_leaderboard_params
    		params.require(:leaderboard_challenge).permit(:first_badge, :firstpic, :second_badge, :secondpic, :third_badge, :thirdpic)
    	end

    	def correct_user
	      @set_challenge = current_user.set_challenges.find_by(id: params[:id])
	      redirect_to activities_path if @set_challenge.nil?
	    end
end
