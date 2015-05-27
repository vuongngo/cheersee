class JoinChallengesController < ApplicationController
	before_action :sign_in?
	before_action :correct_user, only: :destroy
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
	# Post achievement for a challenge
	
	def index
		@join_challenges = JoinChallenge.includes(:user, {join_challenge_comments: :user}, :join_challenge_favs, :set_challenge).where("created_at > ?", Time.at(params[:after].to_i + 1))
		@join_challenge_comment = current_user.join_challenge_comments.new if user_signed_in?
	end
	
	# Create a form for posting
	def new
		@join_challenge = current_user.join_challenges.build(:set_challenge_id => params[:set_challenge_id])
	end

	# Post challenge achievement
	def create
		get_lat_lng(create_join_challenge_params[:latitude], create_join_challenge_params[:longitude])
		update_location(@lat, @long)
		# Create & post challenge achievement
		@join_challenge = current_user.join_challenges.create(create_join_challenge_params)

		# Compare to leaderboard and update info if someone breaks the record
		challenge = create_join_challenge_params[:set_challenge_id]
		point = create_join_challenge_params[:point].to_i
		challenge_measure = SetChallenge.find(create_join_challenge_params[:set_challenge_id])
		if challenge_measure.point_measure == "highest"
			leader = LeaderboardChallenge.where("set_challenge_id = ?", challenge).take
				if point >leader.first_point
					leader.update(first_place: @join_challenge.id, first_point: point, second_place: leader.first_place, second_point: leader.first_point, third_place: leader.second_place, third_point: leader.second_point)
					flash.now[:success] = "Hura! You are now in first place! Congrats!"
				elsif point > leader.second_point && point <= leader.first_point
					leader.update(second_place: @join_challenge.id, second_point: point, third_place: leader.second_place, third_point: leader.second_point)
					flash.now[:success] = "Hura! You are now in second place! Congrats!"
				elsif point > leader.third_point && point <= leader.second_point
					leader.update(third_place: @join_challenge.id, third_point: point)
					flash.now[:success] = "Hura! You are now in third place! Congrats!"
				end 
		elsif challenge_measure.point_measure == "lowest"
			leader = LeaderboardChallenge.where("set_challenge_id = ?", challenge).take
			if point < leader.first_point
				leader.update(first_place: @join_challenge.id, first_point: point, second_place: leader.first_place, second_point: leader.first_point, third_place: leader.second_place, third_point: leader.second_point)
				flash.now[:success] = "Hura! You are now in first place! Congrats!"
			elsif point > leader.second_point && point <= leader.first_point
				leader.update(second_place: @join_challenge.id, second_point: point, third_place: leader.second_place, third_point: leader.second_point)
				flash.now[:success] = "Hura! You are now in second place! Congrats!"
			elsif point < leader.third_point && point >= leader.second_point
				leader.update(third_place: @join_challenge.id, third_point: point)
				flash.now[:success] = "Hura! You are now in third place! Congrats!"
			end 
		end
		# Get data for ajax response
		set_challenges = SetChallenge.includes(:user, {set_challenge_comments: :user}, :set_challenge_favs).where("end_time > ?", Time.zone.now)
  	    get_join_challenges = JoinChallenge.all.includes({user: :profile},:set_challenge, {join_challenge_comments: :user}, :join_challenge_favs)
        @objects = set_challenges + get_join_challenges
        @objects.sort! { |a, b| b.created_at <=> a.created_at  }  
        @objects = Kaminari.paginate_array(@objects).page(params[:page]).per(15)
        @join_challenge_comment = current_user.join_challenge_comments.new
  	    @get_manage_challenge = current_user.manage_challenges.includes(:set_challenge).where("set_challenges.end_time > ?", Time.zone.now)
        @set_challenge_comment = current_user.set_challenge_comments.new
	end

	# Show posts by current user
	def show
		@join_challenge = current_user.join_challenges.includes(:set_challenge)

	end

	# Edit posts by current user
	def edit
		@join_challenge = current_user.join_challenges.find(params[:id])
	end

	# Update post by current user
	def update
		@join_challenge = current_user.join_challenges.find(params[:id])
		if @join_challenge.update_attributes(update_join_challenge_params)
			redirect_to root_path
		else
			redirect_to set_challenges_path
		end
	end

	# Delete post by current user
	def destroy
		@join_challenge.destroy
		replace_leader_after_delete(@join_challenge.set_challenge_id, @join_challenge.id)
		flash[:success] = "Successfully removed!"
		redirect_to root_path
	end

	private
		# Strong parameters for posting challennge achievement
		def create_join_challenge_params
			if params[:join_challenge][:latitude].nil?
				locale = current_user.location
				params[:join_challenge][:latitude] = locale.latitude
				params[:join_challenge][:longitude] = locale.longitude
			end			
			params[:join_challenge][:no_of_fav] = "0"
			params.require(:join_challenge).permit(:set_challenge_id, :point, :content, :longitude, :latitude, :joinchallenge, :no_of_fav)
		end

		# Strong parameters for updating post
		def update_join_challenge_params
			params.require(:join_challenge).permit(:point, :content)
		end

		def correct_user
	      @join_challenge = current_user.join_challenges.find_by(id: params[:id])
	      redirect_to root_path if @join_challenge.nil?
	    end

	    def replace_leader_after_delete(setchallenge, joinchallenge)
			@leaderboard_challenge = LeaderboardChallenge.includes([first: :user], [second: :user], [third: :user]).find_by(set_challenge_id: setchallenge)
			if joinchallenge == @leaderboard_challenge.first_place
				search_for_forth_place(@leaderboard_challenge.third_point, setchallenge, @leaderboard_challenge.third_place)
				replace_first_place_with(@leaderboard_challenge, @join_challenge)
			elsif joinchallenge == @leaderboard_challenge.second_place
				search_for_forth_place(@leaderboard_challenge.third_point, setchallenge, @leaderboard_challenge.third_place)
				replace_second_place_with(@leaderboard_challenge, @join_challenge)
			elsif joinchallenge == @leaderboard_challenge.third_place
				search_for_forth_place(@leaderboard_challenge.second_point, setchallenge, @leaderboard_challenge.second_place)
				replace_third_place_with(@leaderboard_challenge, @join_challenge)
			end
		end

		def search_for_forth_place(max_point, setchallenge, lastjoinchallenge)
			join_challenges = JoinChallenge.where(id: setchallenge).order(point: :desc)
			join_challenges.each do |f|
				if f.point <= max_point && f.id != lastjoinchallenge
					@join_challenge = f
					break
				end
			end
		end

		def replace_first_place_with(leader, replace)
			leader.update(first_place: leader.second_place, first_point: leader.second_point, second_place: leader.third_place, second_point: leader.third_point, third_place: replace.id, third_point: replace.point)
		end

		def replace_second_place_with(leader, replace)
			leader.update(second_place: leader.third_place, second_point: leader.third_point, third_place: replace.id, third_point: replace.point)
		end

		def replace_third_place_with(leader, replace)
			leader.update(third_place: replace.id, third_point: replace.point)
		end
end
