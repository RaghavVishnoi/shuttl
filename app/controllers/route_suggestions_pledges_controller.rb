class RouteSuggestionsPledgesController < ApplicationController
 
	 
	def create
		@route_suggestions_pledge = RouteSuggestionsPledge.new pledge_params
		if @route_suggestions_pledge.save!
			render :json => {result: true,data: @route_suggestions_pledge}
		else
			render :json => @route_suggestions_pledge.errors.full_messages
		end
	end

	def pledge_params
		params.require(:route_suggestions_pledge).permit(:user_id,:approved,:lat,:long,:is_pledge,:route_suggestions_slot_id,:phone,:route_suggestions_timestamp_id)
	end

	def pledge_count
		count = RouteSuggestionsPledge.pledge_count(params[:route_id],params[:pledge])
 		if count != nil
 			render :json => count
 		else
 			render :json => 0
 		end
	end

	def pledge_route
		route = RouteSuggestionsPledge.pledge_route(params[:route_id],params[:pledge])
		if route != nil
			render :json => route
		else
			render :json => 0
		end
	end

	def pledges
		pledges = RouteSuggestionsPledge.pledges(params[:route_id],params[:drop_point_id])
		render :json => pledges
	end

end