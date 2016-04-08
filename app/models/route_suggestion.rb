class RouteSuggestion < ActiveRecord::Base

	attr_accessor :slots,:timestamps

 	has_many :route_suggestions_slots
	validates :name, presence: true
	validates :threshold, presence: true

	def self.route(params)
 		self.all.each do |route|
			if route.route_suggestions_slots.exists?(lat: params[:slat],long: params[:slong]) && route.route_suggestions_slots.exists?(lat: params[:dlat],long: params[:dlong])
				@route_data = route
			end
		end
		@route_data
	end

	def self.slots(slots,timestamps,route_id)
		if slots != nil
			slots.each do |slot|
				RouteSuggestionsSlot.create!(name: slot[:name],lat: slot[:lat],long: slot[:long],time: slot[:time],route_suggestion_id: route_id)
				RouteSuggestionsRoutePoint.create!(lat: slot[:lat],long: slot[:long],route_suggestion_id: route_id)
			end

				timestamps.split(',').each do |time|
				RouteSuggestionsTimestamp.create!(time_departure: time,route_suggestion_id: route_id)
			end
		end
	end

	def self.home_depart(route_id,time,drop_point_id,pickup_point_id)
  		drop_time = RouteSuggestionsSlot.find(drop_point_id).time
		pick_time = RouteSuggestionsSlot.find(pickup_point_id).time
 		departure_time = (Time.parse(Time.parse(time.to_s).strftime("%H:%M:%S")) - drop_time.to_i.minutes).strftime("%I:%M")
 		total_time_to_pick = (Time.parse(Time.parse(departure_time.to_s).strftime("%H:%M:%S")) + pick_time.to_i.minutes).strftime("%I:%M")
 		total_time_to_pick
	end

	def self.nearest_slot(route_id,lat,long)
		RouteSuggestionsSlot.where(lat: (lat.to_f - 0.001)..(lat.to_f + 0.001),long: (long.to_f - 0.001)..(long.to_f + 0.001))
	end

	 

	 


end