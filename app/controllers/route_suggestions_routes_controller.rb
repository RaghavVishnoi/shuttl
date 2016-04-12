class RouteSuggestionsRoutesController < ApplicationController

	def show
		@route = RouteSuggestionsRoute.find(params[:id])
	end

	def update
		@route = RouteSuggestionsRoute.find(params[:id])
		@route.update(state: 'shipped')
		redirect_to '/routes/saved?id='+params[:id]
	end


end