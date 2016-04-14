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

	def route_return
		from = session[:from]
		to = session[:to]
		@route = RouteSuggestionsSlot.nearest_point(to[0],to[1],from[0],from[1])
 		session[:work_route_id] = @route[:route_id].to_s
 		redirect_to '/routes/return?route_id='+@route[:route_id].to_s+'&drop_point_id='+@route[:drop_point_id].to_s
 	end

 	def return
 		puts "from #{session[:from]}"
 		puts "to #{session[:from]}"
  	end


	def find_route
		session[:slat] = params[:slat]
		session[:slong] = params[:slong]
		session[:dlat] = params[:dlat]
		session[:dlong] = params[:dlong]
		slat=params[:slat].to_f
		slng=params[:slong].to_f
		dlat=params[:dlat].to_f
		dlng=params[:dlong].to_f
		result=RoutePoint.where("lat>#{slat-Constants::THRESHOLD_DEVIATION_ALLOWED}").where("lat<#{slat+Constants::THRESHOLD_DEVIATION_ALLOWED}")
		.where("lng>#{slng-Constants::THRESHOLD_DEVIATION_ALLOWED}").where("lng<#{slng+Constants::THRESHOLD_DEVIATION_ALLOWED}")
		if (result!=nil && result.size>0)

			resultDes=RoutePoint.where("lat>#{dlat-Constants::THRESHOLD_DEVIATION_ALLOWED}").where("lat<#{dlat+Constants::THRESHOLD_DEVIATION_ALLOWED}")
																				 .where("lng>#{dlng-Constants::THRESHOLD_DEVIATION_ALLOWED}").where("lng<#{dlng+Constants::THRESHOLD_DEVIATION_ALLOWED}")
			if (resultDes!=nil && resultDes.size>0)
			  resultSourceHash=Hash.new
				resultDesHash=Hash.new
				resultDes.each do |res|
					if (resultDesHash[res[:routeid]]==nil)
						resultDesHash[res[:routeid]]=Array.new
					end
					resultDesHash[res[:routeid]].push res
				end
				result.each do |res|
					if (resultSourceHash[res[:routeid]]==nil)
						resultSourceHash[res[:routeid]]=Array.new
					end
					resultSourceHash[res[:routeid]].push res
				end
				routeIdFound=-1
				pickUpPointIdFound=-1
				resultDesHash.each do |routeid,resultDestination|

					if ( resultSourceHash[routeid]!=nil && resultSourceHash[routeid].size>0)
					 resultSourceHash[routeid].each do |resultSource|
							if (resultSource.locationid!=0)
								routeIdFound=routeid
								pickUpPointIdFound=resultSource.locationid
								break
							end

					 end

					end

					if (pickUpPointIdFound!=-1)
						redirect_to route_exists_path(routeId:routeIdFound,pickUpPointId:pickUpPointIdFound,slat: slat,slng: slng,dlat: dlat,dlng: dlng)
						return
					end
				end
			end
		end
		@route = RouteSuggestionsSlot.nearest_point(params[:slat],params[:slong],params[:dlat],params[:dlong])
   		if @route != nil  
   			from = []
   			from.push(params[:slat],params[:slong])
   			to = []
   			to.push(params[:dlat],params[:dlong])
   			session[:from] = from
			session[:to] = to
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
 			redirect_to root_path(result: false,slat: params[:slat],slong: params[:slong],dlat: params[:dlat],dlong: params[:dlong])
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

  def info
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Request-Method'] = '*'
		headers['Access-Control-Allow-Headers'] = '*'

	end

end