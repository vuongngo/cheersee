class JoinChallengeCommentsController < ApplicationController
	before_action :sign_in?
	# Commend controller for people who share their challenge achievement

	def index
	end

	# Post comment
	def create
		@join_challenge_comments = current_user.join_challenge_comments.build(create_comment)
		@join_challenge_id = create_comment[:join_challenge_id]
		join_challenge = JoinChallenge.find(create_comment[:join_challenge_id])
		if @join_challenge_comments.save
			sync_new @join_challenge_comments, scope: JoinChallengeComment.by_join_challenge(join_challenge)
			join_challenge = JoinChallenge.find(@join_challenge_id)
			if join_challenge.user_id != current_user.id
				GeneralNotification.create!(user_id: join_challenge.user_id, sender_id: current_user.id, join_challenge_id: @join_challenge_id, mes: current_user.name + " commented: '" + create_comment[:comment] + "'' on your post." )
				update_general_notification_count(join_challenge.user_id)
				creat_or_update_potential_rel(join_challenge.user_id, current_user.id, 0, 1, 0)
			end
		else
			flash.now[:error] = "Something happens"
		end
		# @get_join_challenge = JoinChallenge.all.includes(join_challenge_comments: :user)
		# @join_challenge_comment = current_user.join_challenge_comments.new
	end

	def show

	end

	private
		def create_comment
			params.require(:join_challenge_comment).permit(:join_challenge_id , :comment)
		end
end
