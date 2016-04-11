class RoutesController < ApplicationController

	def index
		puts "from #{session[:from]}"
		puts "to #{session[:to]}" 
		puts "lat #{session[:lat]}"
		puts "long #{session[:long]}"
		puts "pickup point #{session[:pickup_point_id]}"
		puts "drop_point_id #{session[:drop_point_id]}"
	
		@route_slot = RouteSuggestionsSlot.find_by(id: params[:pick_point_id],route_suggestion_id: params[:route_id])
		respond_to do |format|
		    format.html
		    format.json
		end
	end	

	def show
		@route_slots = RouteSuggestionsSlot.where(route_suggestion_id: params[:id])
		respond_to do |format|
		    format.html
		    format.json
		end
	end

	def route_return
		from = session[:from]
		to = session[:to]
		@route = RouteSuggestionsSlot.nearest_point(to[0],to[1],from[0],from[1])
 		session[:work_route_id] = @route[:route_id].to_s
 		redirect_to '/routes/return?route_id='+@route[:route_id].to_s+'&drop_point_id='+@route[:drop_point_id].to_s
 	end


	def find_route
		@route = RouteSuggestionsSlot.nearest_point(params[:slat],params[:slong],params[:dlat],params[:dlong])
   		if @route != nil  
   			from = []
   			from.push(params[:slat],params[:slong])
   			to = []
   			to.push(params[:dlat],params[:dlong])
   			session[:from] = from
			session[:to] = to
			session[:lat] = @route[:lat]
			session[:long] = @route[:long]
			session[:s] = params[:s]
			session[:d] = params[:d]
			session[:home_route_id] = @route[:route_id]
	 		session[:drop_point_id] = @route[:drop_point_id]
   			session[:pickup_point_id] = @route[:pickup_point_id]
 			session[:pickup_point_location1] = @route[:pickup_point_location]
 			session[:drop_point_location1] = @route[:drop_point_location]
 			session[:drop_point_id] = @route[:drop_point_id]
 			redirect_to routes_path(route_id: @route[:route_id],drop_point_id: @route[:drop_point_id])
		else
 			redirect_to root_path(result: false)
		end		 
	end
	 

	def user_identification
		@user_pledge = User.identification(params)
		render :json => {result: true,data: @user_pledge}
	end

	def firsttimeslot
		if params[:timeslot].length != 0
			slots = params[:timeslot].split(',') if params[:timeslot] != nil

			if slots != nil
				session[:home_slot] = slots[0].split('F')[0]  			 			
			end	
		end

 		redirect_to '/routes/route_return'
	end

	def secondtimeslot
		if params[:timeslot].length != 0
	  		slots = params[:timeslot].split(',') if params[:timeslot] != nil
			if slots != nil
				 session[:work_slot] = slots[0].split('F')[0]  
			end	
		end
		if session[:home_slot] == nil  && session[:work_slot] == nil 
			redirect_to '/routes/not_interested'
		else
			redirect_to '/routes/info?route_id='+params[:route_id] 
		end
	end

	def location
		render :json => LOCATION
	end


end