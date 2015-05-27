class HashtagsController < ApplicationController
  def index
    @hashtags = SimpleHashtag::Hashtag.all
        @friendhash = Friendhash.new if user_signed_in?
        @friend_request = current_user.inverse_friendships.includes(:user).where(accepted: false) 
        @friendship1 = current_user.friendships.includes(:friend).where(accepted: true) 
        @friendship2 = current_user.inverse_friendships.includes(:user).where(accepted: true) 
        @meetup = Hangout.includes({hangout_messages: :user}, who_hangouts: [{hangout: :who_hangouts}, :user]).where("who_hangouts.user_id = ?", current_user.id) 

  end

  def show
    hashtag = SimpleHashtag::Hashtag.find_by_name("cafe")
    @hashtagged = ShareHangout.all.merge(hashtag.hashtaggables)
    render :json => @hashtagged
        @friend_request = current_user.inverse_friendships.includes(:user).where(accepted: false) 
        @friendship1 = current_user.friendships.includes(:friend).where(accepted: true) 
        @friendship2 = current_user.inverse_friendships.includes(:user).where(accepted: true) 
        @meetup = Hangout.includes({hangout_messages: :user}, who_hangouts: [{hangout: :who_hangouts}, :user]).where("who_hangouts.user_id = ?", current_user.id) 
  end
end
