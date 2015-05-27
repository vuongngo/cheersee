class ChallengeSearchController < ApplicationController
	before_action :sign_in?

	def search
		get_lat_lng(params[:latitude], params[:longitude])
		update_location(@lat, @long)
		Time.zone = current_user.location.user_time_zone
		tag = params[:term]
		tags = tag.split(/\W+/)

		  tags.each do |t|
	        ctag = t.singularize
	        db_tag = Tag.find_or_create_by(:name => ctag)
            TagMap.find_or_create_by(:user_id => current_user.id, :tag_id => db_tag.id)
	      end

		@hashtags = []
		tags.each do |f|
		  hashtag = SimpleHashtag::Hashtag.find_by_name(f)
		  hashtagged = hashtag.hashtaggables if hashtag.present?
		  	if hashtagged.present?
			  hashtagged.each do |f|
			  	if f.respond_to?(:end_time)
			  		if f.end_time > Time.zone.now
			  			@hashtags << f
			  		end
			  	else
			  	@hashtags << f 
			    end
			  end
			end
		end
		@hashtags = @hashtags.uniq if @hashtags.present?
		@set_challenge_comment = current_user.set_challenge_comments.new
		@join_challenge_comment = current_user.join_challenge_comments.new

		if @hashtags.count == 0
			flash.now[:warning] = "We're sorry. We couldn't find any activity with this search!"
		end

	end

	def show
		@show_act = JoinChallenge.includes({user: :profile}, {join_challenge_comments: :user}, :join_challenge_favs).find(params[:id])
		@set_challenge_act = SetChallenge.includes({user: :profile}, {set_challenge_comments: :user}, :set_challenge_favs).find(@show_act.set_challenge_id)
        @join_challenge_comment = current_user.join_challenge_comments.new
        @set_challenge_comment = current_user.set_challenge_comments.new

		refresh_friendlist_of_header
	end

	def show_related_challenge
		@set_challenges = SetChallenge.includes({user: :profile}, {set_challenge_comments: :user}, :set_challenge_favs).find(params[:id])
		@join_challenges = JoinChallenge.includes({user: :profile}, {join_challenge_comments: :user}, :join_challenge_favs).where(set_challenge_id: @set_challenges.id)
		@join_challenge_comment = current_user.join_challenge_comments.new
        @set_challenge_comment = current_user.set_challenge_comments.new

       	refresh_friendlist_of_header
    end
end
