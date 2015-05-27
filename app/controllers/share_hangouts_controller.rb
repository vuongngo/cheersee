class ShareHangoutsController < ApplicationController
  require 'time'
	before_action :sign_in?

  def new
    @location = Array.new
    location_des.map { |b , v| @location.push(v) } 
    @share_hangout = current_user.share_hangouts.build
    @share_hangout.share_hangout_mates.build
  end

  # Share hangout to other users
  def create
    # Tags hangout objectives
    if params[:share_hangout][:tags].present?
      @tag = params[:share_hangout][:tags].split(/\W+/)
      @tag.each do |f|
        Tag.find_or_create_by!(name: f)
      end
    end
    # Save tags for users as interests
    tag_search = Tag.where(name: @tag)
    tag_search.each do |t|
          tagid = t.id
          dup = TagMap.where("user_id = ? AND tag_id = ?", current_user.id, tagid)
          if dup.blank?
          TagMap.create!(user_id: current_user.id, tag_id: tagid)
          end
    end
    # Share hangout
  	@share_hangout = current_user.share_hangouts.create! (share_hangout_params)
      if @share_hangout.present?
        unless share_hangout_params[:open_nearby] == "1" && share_hangout_params[:notify_friend] == "0"
          if share_hangout_params[:notify_friend] == "1"
            if @friendship1.present?
              @friendship1.each do |friend1|
                update_hangout_notification(friend1.friend_id)
              end
            end
            if @friendship2.present?
              @friendship2.each do |friend2|
                update_hangout_notification(friend2.user_id)
              end
            end
          else
            params[:mate_id].each do |f|
                ShareHangoutMate.create!(user_id: f, share_hangout_id: @share_hangout.id)
                update_hangout_notification(f)
            end
          end
        end
        flash[:success] = "Share hangout created!"
        redirect_to activities_path
      else
        flash[:alert] = "Can not create meetup!"
        redirect_to root_url
      end
  end

  def destroy
  end

  private
    # Strong parameters for ShareHangout
    def share_hangout_params
      if params[:share_hangout][:share_time].present?
        pa = params[:share_hangout][:share_time].to_s
        t = Time.parse(pa).strftime("%H:%M:%S")
        d = DateTime.strptime(params[:share_date], "%m/%d/%Y").to_date.to_s
        dt = d + " " + t
        params[:share_hangout][:share_time] = Time.zone.parse(dt)   
      end
      params.require(:share_hangout).permit(:content, :share_time, :business_location, :longitude, :latitude, :business_name, :notify_friend, :open_nearby)
    end

    def location_des
      params.permit(:longitude, :latitude, :business_name, :business_location)
    end
end
