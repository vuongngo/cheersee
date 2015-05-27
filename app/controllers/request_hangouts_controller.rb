class RequestHangoutsController < ApplicationController
  before_action :sign_in?

  # Send request hangout
  def create
  	@request_hangout = current_user.request_hangouts.build(request_hangout_params)
      if @request_hangout.save
        flash[:success] = "Meetup request sent!"
        share_hangout = ShareHangout.find(request_hangout_params[:share_hangout_id])
        update_hangout_notification(share_hangout.user_id)
        redirect_to root_url
      else
        flash[:alert] = "Could not sent request! You might already did it!"
        redirect_to root_url
      end
  end

  def destroy
  end

  private
    # Strong parameters for RequestHangout
    def request_hangout_params
      params.require(:request_hangout).permit(:mes, :share_hangout_id)
    end


end
