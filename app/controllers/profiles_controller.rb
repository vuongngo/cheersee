class ProfilesController < ApplicationController
  before_action :sign_in?
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
	
	def index
			@user_profile = current_user.profile
			@user_preference = current_user.preference
			if @user_profile.avatar.blank?
				flash.now[:warning] = "Please update your profile pic!"
			end
			@reputation = current_user.reputation
			@ref = Reference.includes(:feedback, {user: :profile}).where("receiver_id = ?", current_user.id)
			@fbadges = LeaderboardChallenge.joins(:first).where("join_challenges.user_id = ?", current_user.id)
			@sbadges = LeaderboardChallenge.joins(:second).where("join_challenges.user_id = ?", current_user.id)
			@tbadges = LeaderboardChallenge.joins(:third).where("join_challenges.user_id = ?", current_user.id)
		if params[:id] != current_user.id && params[:id].present?
			uid = params[:id]
			@user_profile = Profile.includes(:user).find_by(user_id: uid)
			@user_preference = Preference.includes(:user).find_by(user_id: uid)
			if @user_profile.avatar.blank?
				flash.now[:warning] = "Please update your profile pic!"
			end
			@reputation = Reputation.find_by(user_id: uid)
			@ref = Reference.includes(:feedback, {user: :profile}).where("receiver_id = ?", uid)
			@fbadges = LeaderboardChallenge.joins(:first).where("join_challenges.user_id = ?", uid)
			@sbadges = LeaderboardChallenge.joins(:second).where("join_challenges.user_id = ?", uid)
			@tbadges = LeaderboardChallenge.joins(:third).where("join_challenges.user_id = ?", uid)			
	    end
		respond_to do |format|
      		format.html
      		format.js
      	end      	
	end

	def show

	end

	def edit
		@user_profile = current_user.profile
	end

	def update
		@user_profile = current_user.profile
		@reputation = current_user.reputation

		unless @user_profile.update_attributes(update_user_profile)
			flash.now[:alert] = "We're sorry! Please try again."
		end

	end

	def edit_gender
		@user_profile = Profile.find(params[:p_id])
	end

	def edit_age
		@user_profile = Profile.find(params[:p_id])
	end

	def edit_hometown
		@user_profile = Profile.find(params[:p_id])
	end

	def edit_avatar
		@user_profile = Profile.find(params[:p_id])
	end

  def user_badges
  	@hid = params[:hid]
    @usr = User.find(params[:user_id])
    @fbadges = LeaderboardChallenge.joins(:first).where("join_challenges.user_id = ?", @usr.id)
    @sbadges = LeaderboardChallenge.joins(:second).where("join_challenges.user_id = ?", @usr.id)
    @tbadges = LeaderboardChallenge.joins(:third).where("join_challenges.user_id = ?", @usr.id)
  end

	private 

		def update_user_profile
			params.require(:profile).permit(:gender, :age, :hometown, :avatar)
		end
end
