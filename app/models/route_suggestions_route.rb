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

	def self.slots(id)
		@routes = RouteSuggestionsRoute.find(id)
		@slots = @routes.slots.split(',')
 		slots = []
		if @slots != nil			
			@slots.each do |slot|
				if slot != nil
					@slot = {}
					@slot[:name] = slot
					@customer_route = CustomerRoute.find_by(name: slot)
					@slot[:lat] = @customer_route.lat
					@slot[:long] = @customer_route.long
					slots.push(@slot)
				end	
			end
			slots
		end
	end

	def self.route_pledge(route_id)
 		@routes = self.find(route_id)
		@points = @routes.slots
		counts = {}
		mcount = 0
		ecount = 0
		if @points != nil
			@points = @points.split(',')
			@points.each do |point|
				@customer_route = CustomerRoute.find_by(name: point)
				@points.each do |drop|
					@drop = CustomerRoute.find_by(name: drop)
					@customers = RouteSuggestionsCustomer.where(from_lat: (@customer_route.lat.to_f - 0.01)..(@customer_route.lat.to_f + 0.01),from_long: (@customer_route.long.to_f - 0.01)..(@customer_route.long.to_f + 0.01),to_lat: (@drop.lat.to_f - 0.01)..(@drop.lat.to_f + 0.01),to_long: (@drop.long.to_f - 0.01)..(@drop.long.to_f + 0.01))
					if @customers.length != 0
						mcount = mcount + @customers.where('time1 != ?','').count
						ecount = ecount + @customers.where('time2 != ?','').count
					end
				end
				
			end
		end
		counts[:m] = mcount
		counts[:e] = ecount
		counts
	end

	def self.pledges(route_id,type)
		@routes = self.find(route_id)
		@points = @routes.slots
		slots = []
		points = []
		if @points != nil
			@points = @points.split(',')
			@points.each do |point|
				@customer_route = CustomerRoute.find_by(name: point)
				@points.each do |drop|
					@drop = CustomerRoute.find_by(name: drop)
					@customers = RouteSuggestionsCustomer.where(from_lat: (@customer_route.lat.to_f - 0.01)..(@customer_route.lat.to_f + 0.01),from_long: (@customer_route.long.to_f - 0.01)..(@customer_route.long.to_f + 0.01),to_lat: (@drop.lat.to_f - 0.01)..(@drop.lat.to_f + 0.01),to_long: (@drop.long.to_f - 0.01)..(@drop.long.to_f + 0.01))
					points.push(@customers.pluck(:id))
					if @customers.length != 0
						if type == 'M'
							slots.push(@customers.where('time1 != ?','').pluck(:time1))
						elsif type == 'E'
							slots.push(@customers.where('time2 != ?','').pluck(:time2))
						end
								
					end
				end
				
			end
			points = points.flatten.uniq
			slots = slots.flatten.uniq
			slot_pledge = []
			slots.each do |slot|
				pledge = {}
				pledge[:slot] = slot
				if type == 'M'
					cus = RouteSuggestionsCustomer.where(id: points,time1: slot)
					pledge[:phone] = cus.pluck(:phone)
					pledge[:count] = cus.count 
				elsif type == 'E'
					cus = RouteSuggestionsCustomer.where(id: points,time2: slot)
					pledge[:phone] = cus.pluck(:phone)
					pledge[:count] = cus.count 
				end
				slot_pledge.push(pledge)					
			end
			slot_pledge
		end
	end

	 
	def self.listPledge(route_id,slot,type)
		@routes = self.find(route_id)
		@points = @routes.slots
		slots = []
		points = []
		if @points != nil
			@points = @points.split(',')
			@points.each do |point|
				@customer_route = CustomerRoute.find_by(name: point)
				@points.each do |drop|
					@drop = CustomerRoute.find_by(name: drop)
					@customers = RouteSuggestionsCustomer.where(from_lat: (@customer_route.lat.to_f - 0.01)..(@customer_route.lat.to_f + 0.01),from_long: (@customer_route.long.to_f - 0.01)..(@customer_route.long.to_f + 0.01),to_lat: (@drop.lat.to_f - 0.01)..(@drop.lat.to_f + 0.01),to_long: (@drop.long.to_f - 0.01)..(@drop.long.to_f + 0.01))
					points.push(@customers.pluck(:id))
					if @customers.length != 0
						if type == 'M'
							slots.push(@customers.where('time1 != ?','').pluck(:time1))
						elsif type == 'E'
							slots.push(@customers.where('time2 != ?','').pluck(:time1))
						end
								
					end
				end
				
			end
			points = points.flatten.uniq
			if type == "M"
				RouteSuggestionsCustomer.where(id: points,time1: slot)
			elsif type == 'E'
				RouteSuggestionsCustomer.where(id: points,time2: slot)
			end
					
		end	
	end 

	def self.live_pledge(pickup_point_id)
		RouteSuggestionsPledge.where(route_suggestions_slot_id: pickup_point_id)
	end

end