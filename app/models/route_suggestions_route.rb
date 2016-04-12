class RouteSuggestionsRoute < ActiveRecord::Base

	def self.route_exists?(start_point,end_point)
		self.exists?(start: start_point,stop: end_point)
	end

	def self.pickup_points(id)
		@routes = self.find(id)
		@routes = @routes.slots.split(',')
		@routes
	end

	def self.customers(pickup_point_name)
		@point = CustomerRoute.find_by(name: pickup_point_name)
		@customers = RouteSuggestionsCustomer.where(from_lat: (@point.lat.to_f - 0.001)..(@point.lat.to_f + 0.001),from_long: (@point.long.to_f - 0.001)..(@point.long.to_f + 0.001))
	end

end