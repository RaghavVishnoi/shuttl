class RouteSuggestionsRoutesController < ApplicationController

	def show
		@route = RouteSuggestionsRoute.find(params[:id])
	end

	def update
		@route = RouteSuggestionsRoute.find(params[:id])
		@route.update(state: 'shipped')
		redirect_to '/routes/saved?id='+params[:id]
	end

	def pledges
		@slots = RouteSuggestionsRoute.pledges(params[:route_id],params[:type])
	end

	def pledge_list
		@customers = RouteSuggestionsRoute.listPledge(params[:route_id],params[:slot],params[:type])
	end

	def message
		@response = Message.send_message(params[:phone],params[:message])
		render :json => true
	end

	def live_pledges
		@pledges = RouteSuggestionsRoute.live_pledge(params[:pickup_point_id])
	end


end