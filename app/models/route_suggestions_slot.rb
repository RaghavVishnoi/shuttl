class RouteSuggestionsSlot < ActiveRecord::Base

	belongs_to :route_suggestion
	has_many :route_sugestions_route_points
	has_many :route_suggestions_pledges

	validates :name, presence: true
	validates :lat, presence: true
	validates :long, presence: true
	validates :time, presence: true
	validates :route_suggestion_id, presence: true

	def self.slot(lat,long,route_id)
		RouteSuggestion.find(route_id).route_suggestions_slots.find_by(lat: lat,long: long).id
	end

	def self.nearest_point(slat,slong,dlat,dlong)
		
 		points = nearest_route_points(slat,slong,dlat,dlong)
  	end

  	def self.nearest_route_points(slat,slong,dlat,dlong)
   		pickup_point_distance = []
   		drop_point_distance = []
   		pickup_route = RouteSuggestionsRoutePoint.where(lat: (slat.to_f - 0.001)..(slat.to_f + 0.001),long: (slong.to_f - 0.001)..(slong.to_f + 0.001))
 		drop_route = RouteSuggestionsRoutePoint.where(lat: (dlat.to_f - 0.001)..(dlat.to_f + 0.001),long: (dlong.to_f - 0.001)..(dlong.to_f + 0.001))
 		pickup_points = pickup_route.where('pickup_point_id != ?',0)
 		if pickup_points != nil && pickup_points.length != 0
  			pickup_points.each do |pickup_point|
 				distance = {}
 				location = []
 				location.push(pickup_point[:lat]).push(pickup_point[:long])
 				dist = Location.distance(slat.to_f,slong.to_f,pickup_point[:lat].to_f,pickup_point[:long].to_f)
 				distance[:route_id] = pickup_point[:route_suggestion_id]
		 		distance[:pickup_point_id] = pickup_point[:pickup_point_id]
		 		distance[:pickup_point_distance] = dist
 		 		distance[:pickup_point_location] = location
		 		pickup_point_distance.push(distance)
 			end
 		else
  			pickup_route.where(pickup_point_id: 0).each do |pickup_point|
 				distance = {}
 				location = []
 				location.push(pickup_point[:lat]).push(pickup_point[:long])
 				dist = Location.distance(slat.to_f,slong.to_f,pickup_point[:lat].to_f,pickup_point[:long].to_f)
 				distance[:route_id] = pickup_point[:route_suggestion_id]
		 		distance[:pickup_point_id] = pickup_point[:pickup_point_id]
		 		distance[:pickup_point_distance] = dist
		 		distance[:pickup_point_location] = location
		 		pickup_point_distance.push(distance)
 			end
 		end
 		drop_points = drop_route.where('drop_point_id != ?',0)
 		if drop_points != nil && drop_points.length != 0
  			drop_points.each do |drop_point|
 				distance = {}
 				location = []
 				location.push(drop_point[:lat]).push(drop_point[:long])
 				dist = Location.distance(dlat.to_f,dlong.to_f,drop_point[:lat].to_f,drop_point[:long].to_f)
 				distance[:route_id] = drop_point[:route_suggestion_id]
		 		distance[:drop_point_id] = drop_point[:drop_point_id]
		 		distance[:drop_point_distance] = dist
		 		distance[:drop_point_location] = location
		 		drop_point_distance.push(distance)
 			end
 		else
  			drop_route.where(drop_point_id: 0).each do |drop_point|
 				distance = {}
 				location = []
 				location.push(drop_point[:lat]).push(drop_point[:long])
 				dist = Location.distance(dlat.to_f,dlong.to_f,drop_point[:lat].to_f,drop_point[:long].to_f)
 				distance[:route_id] = drop_point[:route_suggestion_id]
		 		distance[:drop_point_id] = drop_point[:drop_point_id]
		 		distance[:drop_point_distance] = dist
		 		distance[:drop_point_location] = location
		 		pickup_point_distance.push(distance)
 			end
 		end
 		routes = []
 		pickup_point_distance.each do |pickup_point|
 			if drop_point_distance.any? { |drop_point| drop_point[:route_id] == pickup_point[:route_id]}
 				route = {}
 				route[:route_id] = pickup_point[:route_id]
 				route[:pickup_point_id] = pickup_point[:pickup_point_id]
 				route[:pickup_point_distance] = pickup_point[:pickup_point_distance]
 				route[:pickup_point_location] = pickup_point[:pickup_point_location]
 				drop_point = drop_point_distance.select {|point| point[:route_id] == pickup_point[:route_id]}
 				drop = drop_point.sort_by{|point| point["drop_point_distance"]}.first 1
  				route[:drop_point_id] = drop[0][:drop_point_id]
 				route[:drop_point_distance] = drop[0][:drop_point_distance]
  				route[:drop_point_location] = drop[0][:drop_point_location]
  				routes.push(route)
 			end
 		end
 		route = routes.sort_by { |k| k["pickup_point_distance"] }.first 1
 		route[0]
	end	

		

  	def self.slot_points(route_id)
  		routes = RouteSuggestionsSlot.where(route_suggestion_id: route_id)
  	end




end