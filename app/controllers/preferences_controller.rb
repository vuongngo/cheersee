class PreferencesController < ApplicationController
  def edit_intro
  	@user_preference = Preference.find(params[:p_id])
  end

  def edit_passion
  	@user_preference = Preference.find(params[:p_id])
  end

  def edit_interest
  	@user_preference = Preference.find(params[:p_id])
  end

  def update
  	@user_preference = current_user.preference
	unless @user_preference.update_attributes(update_user_preference)
		flash.now[:alert] = "We're sorry! Please try again."
	end
  end

  private 

	def update_user_preference
		params.require(:preference).permit(:intro, :passion, :interest)
	end
end
