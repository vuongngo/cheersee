class UserAddressesController < ApplicationController
	def update
		@user_address = current_user.user_address
		adr = params[:address]
		if @user_address.update(address: adr)
			flash.now[:success] = "Stay tuned! Merry Christmas!"
		else
			flash.now[:warning] = "We couldn't receive your address. Please re-enter it."
		end
	end
end
