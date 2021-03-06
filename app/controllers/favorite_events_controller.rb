class FavoriteEventsController < ApplicationController

  include UsersHelper
  
  def update
    user = current_user
    if user.blank?
      render json: {
        success: false
      }
      return
    end
    
    favs = FavoriteEvent.where(event_id: params[:event_ids], user_id: user.id)

    if favs.length == 0
      f = FavoriteEvent.create(event_id: params[:event_ids].sort[0].to_i, user_id: user.id)
    else
      f = favs[0]
    end

    f.update_attribute(params[:type], params[:set] == "true")
    f.save

    if not (f.email || f.gcal || f.sms)
      f.delete
    end

    render json: {
      success: true
    }

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
