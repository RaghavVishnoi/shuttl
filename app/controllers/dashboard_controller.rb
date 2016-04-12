class DashboardController < ApplicationController

	def index
		@dashboard = CustomerRoute.route_suggestions_count 
	end

	def save
		result = Dashboard.save(params)
		if result
			render :json => true
		else
			render :json => false
		end
 	end

 	def shipped
 		result = Dashboard.shipped(params)
		if result
			Message.send_link(result.id)
			render :json => true
		else
			render :json => false
		end
 	end




end