class MyMetric < ActiveRecord::Base
	private
	  def create_new_day_metric
	  	dt = Date.today
	  	dt_begin = Time.at_beginning_of_day
	  	dt_end = Time.at_end_of_day
	  	users = User.where("created_at <= ? AND created_at > ?", dt_end, dt_begin).count
	  	challenges = Challenge.where("created_at <= ? AND created_at > ?", dt_end, dt_begin).count
	  	join_challenge = JoinChallenge.where("created_at <= ? AND created_at > ?", dt_end, dt_begin).count
	  	share_meetup = ShareHangout.where("created_at <= ? AND created_at > ?", dt_end, dt_begin).count
	  	hangout = Hangout.where("created_at <= ? AND created_at > ?", dt_end, dt_begin).count
	  	reference = Reference.where("created_at <= ? AND created_at > ?", dt_end, dt_begin).count
	  	MyMetric.create(no_of_user: users, no_of_challenge: challenges, no_of_join_challenge: join_challenge, no_of_share_meetup: share_meetup, no_of_hangout: hangout, no_of_reference: refe, no_of_location_search: 0, every_day: dt)
	  end
end
