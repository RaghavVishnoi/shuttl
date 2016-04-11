class RouteSuggestionsCustomersController < ApplicationController

	def create
		@route_suggestions_create = RouteSuggestionsCustomer.create!(from_lat: params[:from_lat],from_long: params[:from_long],to_lat: params[:to_lat],to_long: params[:to_long],time1: params[:time1],time2: params[:time2],phone: params[:phone],mode: params[:mode])
		if @route_suggestions_create != nil
			render :json =>  true
		else
			render :json =>  false
		end
	end

end