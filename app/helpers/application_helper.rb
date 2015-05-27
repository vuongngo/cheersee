module ApplicationHelper
	def resource_class
  		devise_mapping.to
	end

	def already_friend(closefriend, f1, f2)
      @friend_count = 0
      f1.each do |f| 
        if f.friend.id == closefriend
          @friend_count = @friend_count + 1
        end
      end
      f2.each do |f| 
        if f.user.id == closefriend
          @friend_count = @friend_count + 1
        end
      end  
      if @friend_count != 0
        return true
      else
        return false
      end
    end 

    def winner_of_challenge(challenge, join_challenge)
      @leader = LeaderboardChallenge.find_by(set_challenge_id: challenge)
      if @leader.first_place == join_challenge
      	return 1
      elsif @leader.second_place == join_challenge
      	return 2
      elsif @leader.third_place == join_challenge
      	return 3
      end
    end

end
