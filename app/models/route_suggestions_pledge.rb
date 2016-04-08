class RouteSuggestionsPledge < ActiveRecord::Base

	belongs_to :route_suggestions_slot
	belongs_to :route_suggestions_timestamps


	validates :user_id,presence: true
	validate  :approved
	validates :lat, presence: true
	validates :long, presence: true
	validates :is_pledge, presence: true
	validates :route_suggestions_slot_id, presence: true

	def self.pledge_count(route_id,time)
 		timestamp = RouteSuggestionsTimestamp.find_by(route_suggestion_id: route_id)
 		time_difference = Time.parse(Time.parse(time).strftime("%H:%M:%S")) - Time.parse(Time.parse(timestamp.time_departure.to_s).strftime("%H:%M:%S"))
 		slot = RouteSuggestionsSlot.find_by(route_suggestion_id: route_id,time: (time_difference/60).to_i)
 		if slot != nil
 			RouteSuggestionsPledge.where(route_suggestions_slot_id: slot.id,is_pledge: 1).count
 		end
	end

	def self.total_pledge(route_id)
		RouteSuggestionsPledge.where(route_suggestions_slot_id: RouteSuggestion.find(route_id).route_suggestions_slots).count
	end

	def self.pledges(route_id,drop_point_id)
		timestamps = []
		@drop_point_id = drop_point_id
 		drop_point = RouteSuggestionsSlot.find(@drop_point_id)
 		route_timestamps = RouteSuggestionsTimestamp.where(route_suggestion_id: route_id)
		route_timestamps.each do |timestamp|			
			route_time = {}
			time = Time.parse(timestamp.time_departure.to_s) + drop_point.time.to_i.minutes
			route_time[:time] = time.strftime("%I:%M")
			route_time[:count] = timestamp.route_suggestions_pledges.count	
			pledge = timestamp.route_suggestions_pledges.first
 			pledged_time = ((pledge.created_at + 30.days) - Time.now).to_i/86400
			route_time[:pledge_route] = pledged_time
			timestamps.push(route_time)			
		end
 		time = timestamps.sort_by { |key| key[:count] }.reverse
		time
	end

	def self.pledge_route(route_id,time)
		timestamp = RouteSuggestionsTimestamp.find_by(route_suggestion_id: route_id)
 		time_difference = Time.parse(Time.parse(time).strftime("%H:%M:%S")) - Time.parse(Time.parse(timestamp.time_departure.to_s).strftime("%H:%M:%S"))
 		slot = RouteSuggestionsSlot.find_by(route_suggestion_id: route_id,time: (time_difference/60).to_i)
 		if slot != nil
 			pledge = self.where(route_suggestions_slot_id: slot.id).first
 			(30.days - (Time.now - pledge.created_at)).to_i/86400
 		end

	end

end