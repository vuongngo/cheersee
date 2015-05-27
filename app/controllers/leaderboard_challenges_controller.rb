class LeaderboardChallengesController < ApplicationController
	def show
		@leaderboard_challenge = LeaderboardChallenge.includes([first: :user], [second: :user], [third: :user]).find(params[:id])
	end
end
