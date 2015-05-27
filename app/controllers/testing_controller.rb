class TestingController < ApplicationController
	def index
		@client = GooglePlaces::Client.new("AIzaSyDOonTY7Xlk7rTSrB4drU7y9Dk7QLTznXQ")
   		@response = @client.spots(-33.8670522, 151.1957362, :types => 'restaurant', :opennow => true)
    	render :json => @response
    end
end
