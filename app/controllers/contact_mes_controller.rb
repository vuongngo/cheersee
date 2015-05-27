class ContactMesController < ApplicationController
	def new
		@contact_mes = ContactMe.new
	end

	def create
		@contact_mes = current_user.contact_mes.build(create_new_params)
		if @contact_mes.save
			flash[:success] = "Successfully posted! Thank you!"
	        ContactMailer.ask_question(current_user, create_new_params[:question]).deliver
		end
	end

	private

		def create_new_params
			params.require(:contact_me).permit(:question)
		end
end
