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

	def generate_otp
		otp = rand.to_s[2...6]
		@route_suggestions_otp = RouteSuggestion.add_otp(otp,params[:phone])
		if @route_suggestions_otp != nil
			@send_message = RouteSuggestion.send_otp(otp,params[:phone])
			render :json => {result: true,otp: otp}
		else
			render :json => {result: false,message: 'something went wrong'}
		end
	end

	def check_otp
		@route_suggestions_otp = RouteSuggestion.check_otp(params[:otp],params[:phone])
		render :json => @route_suggestions_otp
	end

	def route_params
		params.require(:route_suggestion).permit(:name,:threshold,{:slots => []},:timestamps)
	end

end