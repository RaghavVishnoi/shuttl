class RoutePoint < ActiveRecord::Base

	def self.hometoworktime(pickup_point,departure_time)
		time = TIMESTAMPS[pickup_point.to_i]
		
	end

end
