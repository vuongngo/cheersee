class SetChallengeCommentsController < ApplicationController
	before_action :sign_in?
	# Comment system for new challenges

	def index
	  @set_challenge_comments = SetChallengeComment.includes(user: :profile).where("set_challenge_id = ? and created_at > ?", params[:set_challenge_id], Time.at(params[:after].to_i + 1))
	end

	def create
		@set_challenge_comments = current_user.set_challenge_comments.build(create_comment)
		@set_challenge_id = create_comment[:set_challenge_id]
		set_challenge = SetChallenge.find(create_comment[:set_challenge_id])
		if @set_challenge_comments.save
			sync_new @set_challenge_comments, scope: SetChallengeComment.by_set_challenge(set_challenge)  
			set_challenge = SetChallenge.find(create_comment[:set_challenge_id])
			  if set_challenge.user_id != current_user.id	
				GeneralNotification.create!(user_id: set_challenge.user_id, sender_id: current_user.id, set_challenge_id: @set_challenge_id, mes: current_user.name + " commented '" + create_comment[:comment] + "' on your '" + set_challenge.post + "' post.")
				update_general_notification_count(set_challenge.user_id)
				creat_or_update_potential_rel(set_challenge.user_id, current_user.id, 0, 1, 0)
			  end
		else
			flash.now[:error] = "Something happens"
		end
		# @get_challenge = SetChallenge.all.includes(:user, {set_challenge_comments: :user})
		# @my_challenge = SetChallenge.where(user_id: current_user.id)
		# @set_challenge_comment = current_user.set_challenge_comments.new
	end

	def show

	end

	private
		def create_comment
			params.require(:set_challenge_comment).permit(:set_challenge_id , :comment)
		end
end
