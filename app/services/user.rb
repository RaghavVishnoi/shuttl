class User

	def self.identification(params)
		@lat = params[:lat]
		@long = params[:long]
		@route_id = params[:route_id]
		@user_id = params[:user_id]
 		@pickup_point = RouteSuggestionsSlot.where(lat: (@lat.to_f - 0.001)..(@lat.to_f + 0.001),long: (@long.to_f - 0.001)..(@long.to_f + 0.001))
		if @pickup_point != nil
			@pickup_point.each do |pickup_point|
				if !RouteSuggestionsPledge.exists?(user_id: @user_id,route_suggestions_slot_id: pickup_point.id)
					RouteSuggestionsPledge.create!(lat: @lat,long: @long,user_id: @user_id,approved: 0,is_pledge: true,route_suggestions_slot_id: pickup_point.id)
				end
			end
		end
	end

	 

end