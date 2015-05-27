class FriendMessagesController < ApplicationController

	def show
        @fid = params[:friendship_id]
        @friend_messages = FriendMessage.includes(user: :profile).where("friendship_id = ?", @fid).order('created_at DESC').limit(10).reverse
	end

	def create
    clear_message_notification
		id = params[:id]
		@friend_messages = current_user.friend_messages.build(friendship_id: id, content: params[:content])
        # respond_to do |format|
            if @friend_messages.save 
              # @friend_messages = FriendMessage.includes(:user).where("friendship_id = ?", id)
              sync_new @friend_messages
              friendship = Friendship.find(id)
              if friendship.user_id = current_user.id
                update_message_notification(friendship.friend_id)
              else
                update_message_notification(friendship.user_id)
              end
            end
        # end
    end


    private

end
