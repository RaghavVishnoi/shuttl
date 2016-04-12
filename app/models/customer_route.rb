class CustomerRoute < ActiveRecord::Base

	def self.route_suggestions_count
		points = []
		self.all.each do |point|
			
			pickup_point = self.find(point.id)
			pickup_point_lat = pickup_point.lat
			pickup_point_long = pickup_point.long

			count = 0
			self.all.each do |drop|
				drop_point_lat = drop.lat
				drop_point_long = drop.long
				customer =  RouteSuggestionsCustomer.where(from_lat: (pickup_point_lat.to_f - 0.01)..(pickup_point_lat.to_f + 0.01),from_long: (pickup_point_long.to_f - 0.01)..(pickup_point_long.to_f + 0.01),to_lat: (drop_point_lat.to_f - 0.01)..(drop_point_lat.to_f + 0.01),to_long: (drop_point_long.to_f - 0.01)..(drop_point_long.to_f + 0.01))
				count = count + customer.count	 
				 
			end
			point_data = {}
			point_data[:name] = point.name
			point_data[:lat] = point.lat
			point_data[:long] = point.long
			point_data[:count] = count
			points.push(point_data)
		end
		points
 	end

end