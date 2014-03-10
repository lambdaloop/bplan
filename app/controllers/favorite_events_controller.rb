class FavoriteEventsController < ApplicationController

  # not needed right now
  def create
    @fav_event = FavoriteEvent.new(fav_params)
    @fav_event.save
    redirect_to root_path
    # if @fav_event.save
    # 	respond_to do |format|
    # 		format.html { redirect_to root_path }
    # 		format.js
    # 	end
    # else
    # 	render "Something is wrong. Sorry."
    # end
  end

  def update
    user = current_user
    favs = FavoriteEvent.where(event_id: params[:event_id], user_id: user.id)

    if favs.length == 0
      f = FavoriteEvent.new(event_id: params[:event_id], user_id: user.id)
    else
      f = favs[0]
    end
    
    f.update_attribute(params[:type], params[:set])

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
