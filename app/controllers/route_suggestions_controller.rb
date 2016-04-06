class RouteSuggestionsController < ApplicationController

	def create
		@route_suggestion = RouteSuggestion.new route_params
		if @route_suggestion.save
			@slots = RouteSuggestion.slots(params[:route_suggestion][:slots],params[:route_suggestion][:timestamps],@route_suggestion.id)
			if @slots != nil
				render :json => {result: true,data: @route_suggestion}
			else
				render :json => {errors: 'Something went wrong!'}
			end
		else
			render :json => @route_suggestion.errors.full_messages
		end
	end

	def route_params
		params.require(:route_suggestion).permit(:name,:threshold,{:slots => []},:timestamps)
	end

end