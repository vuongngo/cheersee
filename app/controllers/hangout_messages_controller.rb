class HangoutMessagesController < ApplicationController
	before_action :sign_in?
	
	def show
        @hid = params[:hangout_id]
        @mes = HangoutMessage.includes(:user).where("hangout_id = ?", @hid)
	end

	def create
    clear_message_notification
		id = params[:id]
		mes = params[:content]
		@hangout_messages = current_user.hangout_messages.build(hangout_id: id, content: mes)
		respond_to do |format|
            if @hangout_messages.save 
              # @friend_messages = FriendMessage.includes(:user).where("friendship_id = ?", id)
              sync_new @hangout_messages
              hangout = Hangout.includes(:who_hangouts).find(id)
              hangout.who_hangouts.each do |f|
              	if f.user_id != current_user.id
                  update_message_notification(f.user_id)
              	end
              end
            end
        end
	end

	private

end
