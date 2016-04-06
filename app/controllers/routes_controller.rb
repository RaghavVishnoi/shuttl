class RoutesController < ApplicationController

	def index
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

	def find_route
		@route = RouteSuggestionsSlot.nearest_point(params)
   		 if @route != nil  
   			from = []
   			from.push(params[:slat],params[:slong])
   			to = []
   			to.push(params[:dlat],params[:dlong])
			redirect_to routes_path(route_id: @route[:route_id],lat: @route[:lat],long: @route[:long],from: from,to: to,s: params[:s],d: params[:d])
		else
			redirect_to '/',alert: 'Path not found!'
		end
 		 
	end
	 

	def user_identification
		@user_pledge = User.identification(params)
		render :json => {result: true,data: @user_pledge}
	end

	def firsttimeslot
		slots = params[:timeslot].split(',') if params[:timeslot] != nil

		if slots != nil
			session[:home_slot] = slots[0]  			 			
		end	
		session[:from] = params[:from]
		session[:to] = params[:to]
		session[:lat] = params[:lat]
		session[:long] = params[:long]
		session[:s] = params[:s]
		session[:d] = params[:d]
 		redirect_to '/routes/return?route_id='+params[:route_id] 
	end

	def secondtimeslot
 		slots = params[:timeslot].split(',') if params[:timeslot] != nil
		if slots != nil
			 session[:work_slot] = slots[0]  
		end	
		if session[:home_slot] == nil  && session[:work_slot] == nil 
			redirect_to '/routes/not_interested'
		else
			redirect_to '/routes/info?route_id='+params[:route_id] 
		end
	end


end