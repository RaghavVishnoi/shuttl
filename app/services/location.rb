class Location
	

	def self.distance(lat1,long1,lat2,long2)
		Haversine.distance(lat1, long1, lat2, long2).to_meters
 	end

	def self.nearby(distance,slat,slong)
		@routes = RouteSuggestionsSlot.near([slat, slong], distance, units: :km)
	end

	 

end