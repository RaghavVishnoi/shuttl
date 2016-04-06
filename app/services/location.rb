class Location

	def self.distance(params)
		distance = Geocoder::Calculations.distance_between([params[:slat],params[:slong]],[params[:dlat],params[:dlong]])
		nearby(distance,params[:slat],params[:slong])
	end

	def self.nearby(distance,slat,slong)
		@routes = RouteSuggestionsSlot.near([slat, slong], distance, units: :km)
	end


end