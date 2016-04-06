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

	def self.home_depart(route_id,lat,long)
		slot_id = nearest_slot(route_id,lat,long).last.id
		departure_time(slot_id,route_id)
	end

	def self.home_arrive(route_id,lat,long)
		slot_id = nearest_slot(route_id,lat,long).last.id
		
	end

	def self.nearest_slot(route_id,lat,long)
		RouteSuggestionsSlot.where(lat: (lat.to_f - 0.001)..(lat.to_f + 0.001),long: (long.to_f - 0.001)..(long.to_f + 0.001))
	end

	def self.departure_time(slot_id,route_id)
		time = RouteSuggestionsSlot.find(slot_id).time
		route_time = RouteSuggestionsTimestamp.find_by(route_suggestion_id: route_id).time_departure
		slot_time = (RouteSuggestionsSlot.find(slot_id).time*60)
		if slot_time != 0
			route_time + slot_time.strftime("%I:%M %P")
		else
			route_time.strftime("%I:%M")
		end
		
	end

	def self.arrival_time(slot_id)
		time = RouteSuggestionsSlot.find(slot_id).time
		route_time = RouteSuggestionsTimestamp.find_by(route_suggestion_id: route_id).time
		slot_time = (RouteSuggestionsSlot.find(slot_id).time*60)
		if slot_time != 0
			route_time - slot_time.strftime("%I:%M %P")
		else
			route_time.strftime("%I:%M")
		end
	end


end