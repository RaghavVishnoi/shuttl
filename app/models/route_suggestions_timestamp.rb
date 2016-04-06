class RouteSuggestionsTimestamp < ActiveRecord::Base

	belongs_to :route_suggestions

	validates :time_departure,presence: true
	validates :route_suggestion_id, presence: true

	def self.slot_time(route_id,slot_id)
		time = []
		self.where(route_suggestion_id: route_id).each do |route|
			time.push((route.time_departure+RouteSuggestionsSlot.find(slot_id).time*60).strftime("%I:%M %P"))
		end
		time
	end

end