class FeedbacksController < ApplicationController

	def create
		@feedback = Feedback.create(params)
		if @feedback != nil
			render :json => true
		else
			render :json => @feedback.errors.full_messages
		end
	end

	def feedback_params
		params.require(:feedback).permit(:message,:user_id)
	end

end