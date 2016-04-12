class Location
	require 'httparty'

	def self.distance(lat1,long1,lat2,long2)
		Haversine.distance(lat1, long1, lat2, long2).to_meters
 	end

	def self.nearby(distance,slat,slong)
		@routes = RouteSuggestionsSlot.near([slat, slong], distance, units: :km)
	end

	def self.time(lat1,long1,lat2,long2)
		response = HTTParty.get('https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins='+lat1+','+long1+'&destinations='+lat2+','+long2+'&key=AIzaSyAWdJ3F1a1pmCUjyHaINmV1_nOJ6hpbArM')
		puts "response #{response}"
	end

	 

end