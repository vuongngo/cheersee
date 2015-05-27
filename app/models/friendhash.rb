class Friendhash < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user_id, :token, :expired_at, :lat, :lng
	validates_uniqueness_of :token

	private
	  def delete_friend_hash
	  	t = Time.current - 1.days
	  	@friendhashes = Friendhash.where("expired_at < ?", t)
	  	@friendhashes.destroy_all
	  end
end
