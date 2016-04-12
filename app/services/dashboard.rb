class Dashboard

	def self.save(data)
		values = data[:values]
		length = values.length
		count_people = 0
		slots = ''
		if values != nil
			values.each do |value|
				val = value[1]
 				count_people = count_people+val[:people].to_i			 
				slots = slots+"  ,"+val[:name]
			end 
		end
  		@route_suggestions_routes = RouteSuggestionsRoute.new
		@route_suggestions_routes[:name] = values.first[1][:name]
		@route_suggestions_routes[:people] = count_people
 		@route_suggestions_routes[:state] = 'saved'
		@route_suggestions_routes[:status] = 'Active'
		@route_suggestions_routes[:start] = values.first[1][:name]
		@route_suggestions_routes[:stop] = values.to_a.last[1][:name]
		@route_suggestions_routes[:points] = values.length
		@route_suggestions_routes[:slots] = slots
		@route_suggestions_routes[:route_type] = 'PPPD'
		@route_suggestions_routes[:distance] = distance(values.first[1][:name],values.to_a.last[1][:name])
		@route_suggestions_routes.save!	
		@route_suggestions_routes
	end

	def self.shipped(data)
		values = data[:values]
		length = values.length
		count_people = 0
		slots = ''
		if values != nil
			values.each do |value|
				val = value[1]
 				count_people = count_people+val[:people].to_i			 
				slots = slots+"  ,"+val[:name]
			end 
		end
		
		@route_suggestions_routes = RouteSuggestionsRoute.new
		@route_suggestions_routes[:name] = values.first[1][:name]
		@route_suggestions_routes[:people] = count_people
 		@route_suggestions_routes[:state] = 'shipped'
		@route_suggestions_routes[:status] = 'Active'
		@route_suggestions_routes[:start] = values.first[1][:name]
		@route_suggestions_routes[:stop] = values.to_a.last[1][:name]
		@route_suggestions_routes[:points] = values.length
		@route_suggestions_routes[:slots] = slots
		@route_suggestions_routes[:route_type] = 'PPPD'
		@route_suggestions_routes[:distance] = distance(values.first[1][:name],values.to_a.last[1][:name])
		@route_suggestions_routes.save!	
		@route_suggestions_routes
	end

	def self.distance(start_point,end_point)
		start = CustomerRoute.find_by(name: start_point)
		stop = CustomerRoute.find_by(name: end_point)
		Location.distance(start.lat.to_f,start.long.to_f,stop.lat.to_f,stop.long.to_f)/1000
	end




end