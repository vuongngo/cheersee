class StaticPagesController < ApplicationController
  
  def home
      if user_signed_in?
        Time.zone = current_user.location.user_time_zone
        find_records_for_headers
        set_challenges = SetChallenge.includes(:user, {set_challenge_comments: :user}, :set_challenge_favs).where("end_time > ?", Time.zone.now)
  	    get_join_challenges = JoinChallenge.all.includes({user: :profile},:set_challenge, {join_challenge_comments: :user}, :join_challenge_favs)
        @objects = set_challenges + get_join_challenges
        @objects.sort! { |a, b| b.created_at <=> a.created_at  }  
        @objects = Kaminari.paginate_array(@objects).page(params[:page]).per(15)
        @join_challenge_comment = current_user.join_challenge_comments.new
  	    @get_manage_challenge = current_user.manage_challenges.includes(:set_challenge).where("set_challenges.end_time > ?", Time.zone.now)
        @set_challenge_comment = current_user.set_challenge_comments.new
          if current_user.sign_in_count == 1 && current_user.profile.gender.nil?
            flash.now[:warning] = "Hura! You just receive a life-time badges and first reference on your profile. Please update your profile before continue with other activities."
            redirect_to profiles_path
          else
            respond_to do |format|
              format.html
              format.js
            end
          end
        end
  end

  def about_us
  end

  def committed_act
    get_join_challenges = current_user.join_challenges.includes({user: :profile},:set_challenge, {join_challenge_comments: :user}, :join_challenge_favs).page params[:page]
    set_challenges = current_user.set_challenges.includes(:user, {set_challenge_comments: :user}, :set_challenge_favs).where("end_time > ?", Time.zone.now - 10.days)
    @objects = get_join_challenges + set_challenges
    @objects.sort! { |a, b| b.created_at <=> a.created_at  } 
    @objects = Kaminari.paginate_array(@objects).page(params[:page]).per(15)
    @join_challenge_comment = current_user.join_challenge_comments.new if user_signed_in?
    @set_challenge_comment = current_user.set_challenge_comments.new if user_signed_in?
  end

  def search
    get_lat_lng(params[:latitude], params[:longitude])
    update_location(@lat, @long)
    Time.zone = @timezone.active_support_time_zone
    t = Time.zone.now
    out_date = Friendhash.where("expired_at < ?", t)
    unless out_date.nil?
      if out_date.destroy_all
        @friend = Friendhash.includes(:user).where(token: params[:token]).where.not(user_id: current_user.id).take
        didfriend1 = Friendship.where("user_id = ? AND friend_id = ?", current_user.id, @friend.user_id) unless @friend.nil?
        didfriend2 = Friendship.where("user_id = ? AND friend_id = ?", @friend.user_id, current_user.id) unless @friend.nil?
          if didfriend1.present? || didfriend2.present?
            @friend = nil
          end  
        if @friend.nil?
          flash.now[:warning] = "No friend found!"
        end
      end
    end
  end

  def friend_activities
    Time.zone = current_user.location.user_time_zone
    @friendship1.each do |f|
      set_challenges = SetChallenge.includes(user: :profile).where(user_id: f.friend_id)
      join_challenges = JoinChallenge.includes(user: :profile).where(user_id: f.friend_id)
      @actions = set_challenges + join_challenges
    end
    @friendship2.each do |f|
      set_challenges = SetChallenge.includes(user: :profile).where(user_id: f.user_id)
      join_challenges = JoinChallenge.includes(user: :profile).where(user_id: f.user_id)
      @actions = set_challenges + join_challenges
    end
    if @actions.nil?
      flash.now[:warning] = "Your friends are idle. Lets warm them up now!"
    else
      @actions.sort! { |a, b| b.created_at <=> a.created_at  } 
      @actions = Kaminari.paginate_array(@actions).page(params[:page]).per(15)
    end
    @join_challenge_comment = current_user.join_challenge_comments.new if user_signed_in?
    @set_challenge_comment = current_user.set_challenge_comments.new if user_signed_in?
  end

  def favorite
    @jid = params[:challenge]
    join_challenge_fav = current_user.join_challenge_favs.build(join_challenge_id: @jid)
    join_challenge = JoinChallenge.includes(:user).find(@jid)
    @fav = join_challenge.no_of_fav + 1
    if join_challenge_fav.save!
      if join_challenge.update(no_of_fav: @fav)
        flash[:success] = "Favorited"
          if join_challenge.user_id != current_user.id
          GeneralNotification.create!(user_id: join_challenge.user_id, sender_id: current_user.id, join_challenge_id: join_challenge.id, mes: current_user.name + " favorited your post.")
          update_general_notification_count(join_challenge.user_id)
          creat_or_update_potential_rel(join_challenge.user_id, current_user.id, 1, 0, 0)
          end
      else
        flash[:alert] = "Couldn't favorite"
        end
    end
    respond_to do |format|
        format.html
        format.js
      end
  end

  private    
  
end
