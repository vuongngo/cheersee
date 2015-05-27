class ReferencesController < ApplicationController
	def show
		@reference = Reference.includes(:feedback).find(params[:id])
	end
end
