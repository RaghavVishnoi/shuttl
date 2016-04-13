class RouteSuggestionsTimestamp < ActiveRecord::Base

	belongs_to :route_suggestions
	has_many :route_suggestions_pledges

	validates :time_departure,presence: true
	validates :route_suggestion_id, presence: true

	def self.slot_time(route_id,slot_id)
		time = []
		self.where(route_suggestion_id: route_id).each do |route|
			time.push((route.time_departure+RouteSuggestionsSlot.find(slot_id).time*60).strftime("%I:%M %P"))
		end
		time
	end

	def self.find_timestamp(route_id,time,pickup_point_id)
		@slot_time = RouteSuggestionsSlot.find(pickup_point_id).time
		@estimate_departure_time = (Time.parse(time) + @slot_time.to_i.minutes).strftime("%H:%M:%S")
		@timestamps = RouteSuggestionsTimestamp.where(route_suggestion_id: route_id)
		@time = []
		@timestamps.each do |timestamp|
			time_difference = {}
			time_difference[:timestamp] = timestamp
			time_difference[:id] = timestamp.id
 			difference = (Time.parse(Time.parse(@estimate_departure_time.to_s).strftime("%H:%M:%S")) - Time.parse(Time.parse(timestamp.time_departure.to_s).strftime("%H:%M:%S")))
			time_difference[:difference] = difference
			@time.push(time_difference)
		end
		result = @time.sort_by { |k| k[:difference]}
		result
	end

end