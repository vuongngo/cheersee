class ApplicationController < ActionController::Base
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_action :find_records_for_headers, if: :signed_in?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless user_signed_in?
        redirect_to root_url
      end
    end

    def sign_in?
      unless user_signed_in?
        redirect_to root_path
      end
    end

    def get_lat_lng(latitude, longitude)
      if latitude.nil?
        locale = current_user.location
        if locale.nil?
          result = request.location
          @lat = result.latitude
          @long = result.longitude
        else
          @lat = locale.latitude
          @long = locale.longitude
        end
      else
        @lat = latitude
        @long = longitude
      end
    end

    def save_location(latitude, longitude)
        @timezone = Timezone::Zone.new :latlon => [latitude, longitude]
        Location.create!(user_id: current_user.id, latitude: latitude, longitude: longitude, user_time_zone: @timezone.active_support_time_zone)
    end

    def update_location(latitude, longitude)
      if latitude.present? && longitude.present?   
        if locale = current_user.location.nil?
          save_location(latitude, longitude)
        else
          locale = current_user.location
          @timezone = Timezone::Zone.new :latlon => [latitude, longitude]
          locale.update!(latitude: latitude, longitude: longitude, user_time_zone: @timezone.active_support_time_zone)
        end
      end
    end

    def find_records_for_headers
      @friendhash = Friendhash.new 
      @friend_request = current_user.inverse_friendships.includes(user: :profile).where(accepted: false) 
      @friendship1 = current_user.friendships.includes(friend: :profile).where(accepted: true) 
      @friendship2 = current_user.inverse_friendships.includes(user: :profile).where(accepted: true) 
      @meetup = Hangout.includes({hangout_messages: :user}, who_hangouts: [{hangout: :who_hangouts}, {user: :profile}]).where("who_hangouts.user_id = ?", current_user.id)
      @g_not_count = current_user.general_notification_count
      @m_not_count = current_user.message_notification
      @h_not_count = current_user.hangout_notification
    end   

    def refresh_friendlist_of_header
      @friendhash = Friendhash.new 
      @friend_request = current_user.inverse_friendships.includes(:user).where(accepted: false) 
      @friendship1 = current_user.friendships.includes(friend: :profile).where(accepted: true) 
      @friendship2 = current_user.inverse_friendships.includes(user: :profile).where(accepted: true) 
      @meetup = Hangout.includes({hangout_messages: :user}, who_hangouts: [{hangout: :who_hangouts}, {user: :profile}]).where("who_hangouts.user_id = ?", current_user.id)
    end
    
    def clear_hangout_notification
      h_note = HangoutNotification.find_by(user_id: current_user.id)
      h_note.update(unread_count: 0)
    end

    def update_hangout_notification(friend)
      h_note = HangoutNotification.find_by(user_id: friend)
      count = h_note.unread_count + 1
      h_note.update(unread_count: count)
    end

    def clear_message_notification
      m_note = MessageNotification.find_by(user_id: current_user.id)
      m_note.update(unread_count: 0)
    end

    def update_message_notification(friend)
      m_note = MessageNotification.find_by(user_id: friend)
      count = m_note.unread_count + 1
      m_note.update(unread_count: count)
    end

    def clear_general_notification_count
      g_note = GeneralNotificationCount.find_by(user_id: current_user.id)
      g_note.update(unread_count: 0)
    end

    def update_general_notification_count(friend)
      g_note = GeneralNotificationCount.find_by(user_id: friend)
      count = g_note.unread_count + 1
      g_note.update(unread_count: count)
    end

    def increase_no_of_location_search
      dt = Date.today
      @my_metric = MyMetric.find_by(every_day: dt)
      if @my_metric.nil?
        @my_metric = MyMetric.find_by(every_day: dt - 1.days)
      end
      unless @my_metric.nil?
      @my_metric.no_of_location_search = @my_metric.no_of_location_search + 1 
      @my_metric.save!
      end
    end

    def open_dating_mechanism(user)
      potential_rel1 = user.potential_relationships 
      potential_rel2 = user.inverse_potential_relationships
      @potential = Array.new
      potential_rel1.each do |f|
        rel = Hash.new()
        rel[:id] = f.stranger_id
        rel[:score] = f.like_no*2 + f.comment_no*5 + f.joint_no*20 
        @potential.push(rel)
      end
      potential_rel2.each do |f|
        rel = Hash.new()
        rel[:id] = f.user_id
        rel[:score] = f.like_no*2 + f.comment_no*5 + f.joint_no*20 
        @potential.push(rel)
      end
      @potential = @potential.sort_by { |k| k[:score] } if @potential.present?
    end

    def creat_or_update_potential_rel(id_1, id_2, l_no, c_no, j_no)
      rel = PotentialRelationship.find_by(user_id: id_1, stranger_id: id_2)
      if rel.nil?
        rel = PotentialRelationship.create!(user_id: id_1, stranger_id: id_2, like_no: l_no, comment_no: c_no, joint_no: j_no)
      else
        like_no = rel.like_no + l_no
        comment_no = rel.comment_no + c_no
        joint_no = rel.joint_no + j_no
        rel.update!(like_no: like_no, comment_no: comment_no, joint_no: joint_no)
      end
    end    

    protected

      def configure_devise_permitted_parameters
        registration_params = [:name, :email, :password, :password_confirmation]
        if params[:action] == 'update'
          devise_parameter_sanitizer.for(:account_update) { 
            |u| u.permit(registration_params << :current_password)
          }
        elsif params[:action] == 'create'
          devise_parameter_sanitizer.for(:sign_up) { 
            |u| u.permit(registration_params) 
          }
        end
      end
end
