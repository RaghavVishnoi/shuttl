class RouteSuggestionsSlot < ActiveRecord::Base

	belongs_to :route_suggestion
	has_many :route_sugestions_route_points

	validates :name, presence: true
	validates :lat, presence: true
	validates :long, presence: true
	validates :time, presence: true
	validates :route_suggestion_id, presence: true

	def self.slot(lat,long,route_id)
		RouteSuggestion.find(route_id).route_suggestions_slots.find_by(lat: lat,long: long).id
	end

	def self.nearest_point(params)
		pickup_point1 = []
		pickup_point2 = []
 		points = nearest_route_points(params)
 		slots = nearest_pickup_point(params)
		route_points1 = points[:pickup_point]
		pickup_points1 = slots[:pickup_point]
		if route_points1 != nil
			pickup_routes = route_points1.map{|point| point[:route_id]}
			if points[:drop_point].select{|point| pickup_routes.include?(point[:route_id])} != nil
					pickup_point1.push(points[:pickup_point])
			end		
		end
  		if route_points1 != nil 
			pickup_routes = route_points1.map{|point| point[:route_id]}
			if slots[:drop_point].select{|point| pickup_routes.include?(point[:route_id])} != nil
					pickup_point2.push(slots[:pickup_point])
			end		
		end

  			route1 = pickup_point1.sort_by { |k| k[0]["distance"] }[0][0] if pickup_point1[0][0] != nil  
	 		route2 = pickup_point2.sort_by { |k| k[0]["distance"] }[0][0] if pickup_point2[0][0] != nil 
	 	if route1 != nil && route2 != nil 
	 		if points[:drop_point].length == 0 && slots[:drop_point].length == 0
	 		
	 		else
		 		distance1 = route1[:distance]
		 		distance2 = route2[:distance]
		 		if distance1 < distance2
		 			route1
		 		else
		 			route2
		 		end
	 		end
 		end
  	end

  	def self.nearest_route_points(params)
  		points = {}
  		pickup_points = []
		pickup_point = "SELECT `id`,(6373 * acos(cos( radians( #{params[:slat]} ) ) * 
			cos( radians( `lat` ) ) * cos(radians( `long` ) - radians( #{params[:slong]} ))
			+ sin(radians(#{params[:slat]})) * sin(radians(`lat`)))) `distance` FROM shuttl.route_suggestions_route_points 
			HAVING `distance` < 0.00157828 ORDER BY `distance`"

		result = ActiveRecord::Base.connection.execute(pickup_point)
 		if result != nil
	 		result.each do |res|
	 			data = {}
	 			route = RouteSuggestionsRoutePoint.find_route(res[0])
	 			data[:route_id] = route.id
	 			data[:distance] = res[1]
	 			data[:lat] = route.lat
	 			data[:long] = route.long
 	 			pickup_points.push(data)
	 		end
 		end
 		points[:pickup_point] = pickup_points
 		 
  		drop_points = []
		drop_point = "SELECT `id`,(6373 * acos(cos( radians( #{params[:dlat]} ) ) * 
			cos( radians( `lat` ) ) * cos(radians( `long` ) - radians( #{params[:dlong]} ))
			+ sin(radians(#{params[:dlat]})) * sin(radians(`lat`)))) `distance` FROM shuttl.route_suggestions_route_points 
			HAVING `distance` < 0.00157828 ORDER BY `distance`"

		result = ActiveRecord::Base.connection.execute(drop_point)
 		if result != nil
	 		result.each do |res|
	 			data = {}
	 			route = RouteSuggestionsRoutePoint.find_route(res[0])
 		 			data[:route_id] = route.id
		 			data[:distance] = res[1]
		 			data[:lat] = route.lat
		 			data[:long] = route.long
	 	 			drop_points.push(data)
	 	 		 	
 	 		end
 		end 		 
     	points[:drop_point] = drop_points
   		points
  	end

  	def self.nearest_pickup_point(params)
  		points = {}
  		pickup_points = []
		pickup_point = "SELECT `id`,(6373 * acos(cos( radians( #{params[:slat]} ) ) * 
			cos( radians( `lat` ) ) * cos(radians( `long` ) - radians( #{params[:slong]} ))
			+ sin(radians(#{params[:slat]})) * sin(radians(`lat`)))) `distance` FROM shuttl.route_suggestions_slots 
			HAVING `distance` < 0.00157828 ORDER BY `distance`"

		result = ActiveRecord::Base.connection.execute(pickup_point)
 		if result != nil
	 		result.each do |res|
	 			data = {}
	 			route = RouteSuggestionsSlot.find(res[0])
	 			data[:route_id] = route.id
	 			data[:distance] = res[1]
	 			data[:lat] = route.lat
	 			data[:long] = route.long
 	 			pickup_points.push(data)
	 		end
 		end
 		points[:pickup_point] = pickup_points
 		drop_points = []
		drop_point = "SELECT `id`,(6373 * acos(cos( radians( #{params[:dlat]} ) ) * 
			cos( radians( `lat` ) ) * cos(radians( `long` ) - radians( #{params[:dlong]} ))
			+ sin(radians(#{params[:dlat]})) * sin(radians(`lat`)))) `distance` FROM shuttl.route_suggestions_slots 
			HAVING `distance` < 0.00157828 ORDER BY `distance`"

		result = ActiveRecord::Base.connection.execute(drop_point)
 		if result != nil
	 		result.each do |res|
	 			data = {}
 	 			route = RouteSuggestionsSlot.find(res[0])
	 			data[:route_id] = route.id
	 			data[:distance] = res[1]
	 			data[:lat] = route.lat
	 			data[:long] = route.long
 	 			drop_points.push(data)
 	 		end
 		end
 		points[:drop_point] = drop_points 
   		points
  	end

  	def self.slot_points(route_id)
  		routes = RouteSuggestionsSlot.where(route_suggestion_id: route_id)
  	end




end