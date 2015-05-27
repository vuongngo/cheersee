class LocationSearchController < ApplicationController
  before_action :sign_in?
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  # Controller for hangout page

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end 

  def search
    increase_no_of_location_search
    # Build share & request hangout 
    @request_hangout = current_user.request_hangouts.build

    # Locate user
    get_lat_lng(params[:latitude], params[:longitude])
    #set time zone
    update_location(@lat, @long)
    # Fetch Yelp API
    # coordinates = { latitude: lat, longitude: long }
    # parameters = { term: params[:term], limit: 10, sort: 0+2 }
    # @response = Yelp.client.search_by_coordinates(coordinates, parameters)

    # Google API
    @client = GooglePlaces::Client.new("AIzaSyDOonTY7Xlk7rTSrB4drU7y9Dk7QLTznXQ")
    @response = Kaminari.paginate_array(@client.spots(@lat, @long, :name => params[:term], :radius => 5000, :exclude=> ['travel_agency', 'storage', 'roofing_contrator', 'pharmacy', 'moving_company'], :opennow => true)).page(params[:page]).per(20)
    # if @response.nil?
    #   flash.now[:warning] = "We couldn't find any place. Please use another term."
    # end
    # @response = Kaminari.paginate_array(@responses).page(params[:page]).per(5)
    # Create a bounding box to search for users nearby
    distance = 50
    center_point = [@lat, @long]
    box = Geocoder::Calculations.bounding_box(center_point, distance)
    # Create time attributes
    timezone = Timezone::Zone.new :latlon => [@lat, @long]
    Time.zone = timezone.active_support_time_zone
      t = Time.zone.now

    # Query with tag, seach for people nearby
    @tag = params[:term]
    if @tag.present? == true
      tags = @tag.split(/\W+/)

      tags.each do |t|
        tag = t.singularize
        db_tag = Tag.find_or_create_by(:name => tag)
        TagMap.find_or_create_by(:user_id => current_user.id, :tag_id => db_tag.id)
      end
    end

    #   tags.each do |f|
    #     hashtag = SimpleHashtag::Hashtag.find_by_name(f)
    #     if hashtag.present?
    #     @nearby_users = ShareHangout.includes({user: :profile}, {user: :reputation}, {user: :references}).where("share_time >= :begin_time AND share_time <= :end_time 
    #                                       AND longitude >= :lower_long AND latitude >= :lower_lat
    #                                       AND longitude <= :upper_long AND latitude <= :upper_lat AND open_nearby = true", 
    #                                       {begin_time: t[0], end_time: t[1], lower_lat: box[0],
    #                                         lower_long: box[1], upper_lat: box[2], upper_long: box[3]} ).where.not(user_id: current_user.id).merge(hashtag.hashtaggables)
    #     end      
    #   end
    # else
    open_dating_mechanism(current_user)
    unless @potential.nil?
      @potential.each do |f|
        @nearby_users = ShareHangout.includes({user: :profile}, {user: :reputation}, {user: :references}).where("share_time >= :begin_time 
                                          AND longitude >= :lower_long AND latitude >= :lower_lat
                                          AND longitude <= :upper_long AND latitude <= :upper_lat AND open_nearby = true
                                          AND user_id = :uid", 
                                          {begin_time: t, lower_lat: box[0],
                                            lower_long: box[1], upper_lat: box[2], upper_long: box[3], uid: f[:id]} ).where.not(user_id: current_user.id)
      end
    end
    
    if @nearby_users.nil? 
      flash.now[:warning] = "Couldn't find any people nearby for meetup. Create your own meetup is the fastest way to hangout :) !"
    elsif @nearby_users.count == 0
      flash.now[:warning] = "Couldn't find any people nearby for meetup. Create your own meetup is the fastest way to hangout :) !"
    else
      @nearby_users = Kaminari.paginate_array(@nearby_users).page(params[:page])
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def map
    @location1 = Array.new
    @location1[0] = params[:maplat].to_f
    @location1[1] = params[:maplng].to_f
    locale2 = Location.where(user_id: current_user.id).take
    @bid = params[:businessid]
    unless locale2.nil?
      @location2 = [locale2.latitude, locale2.longitude]
    end
  end
end
