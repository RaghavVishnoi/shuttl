class RouteSuggestionsPledge < ActiveRecord::Base

	belongs_to :route_suggestions_slot

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

	def self.is_fullfast(route_id,time)
		all_count = is_max(route_id).sort_by {|_key, value| value}.reverse.first 2
 		timestamp = RouteSuggestionsTimestamp.find_by(route_suggestion_id: route_id)
 		time_difference = Time.parse(Time.parse(time).strftime("%H:%M:%S")) - Time.parse(Time.parse(timestamp.time_departure.to_s).strftime("%H:%M:%S"))
 		slot = RouteSuggestionsSlot.find_by(route_suggestion_id: route_id,time: (time_difference/60).to_i)
 		if all_count[0][slot.id] != nil
			true
		else
			false
		end
	end

	def self.is_max(route_id)
		 slots = RouteSuggestion.find(route_id).route_suggestions_slots
		 slot_pledge_count = {}
		 slots.each do |slot|
		 	count = RouteSuggestionsPledge.where(route_suggestions_slot_id: slot.id,is_pledge: 1).count
		 	slot_pledge_count[slot.id] = count
		 end
		 slot_pledge_count
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