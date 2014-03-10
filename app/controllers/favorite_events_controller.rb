class FavoriteEventsController < ApplicationController

	def create
		@fav_event = FavoriteEvent.new(fav_params)
		@fav_event.save
		redirect_to root_path
		if @fav_event.save
			respond_to do |format|
				format.html { redirect_to root_path }
				format.js
			end
		else
			render "Something is wrong. Sorry."
		end
	end

	def destroy
		@fav_event = FavoriteEvent.find(params[:id])
		@fav_event.destroy
		redirect_to root_path
	end

	private
	def fav_params
		params[:favorite_event].permit(:user_id, :event_id)
	end
end
