class FeedbacksController < ApplicationController

	def create
		@feedback = Feedback.create(feedback_params)
		if @feedback != nil
			render :json => @feedback
		else
			render :json => @feedback.errors.full_messages
		end
	end

	def feedback_params
		params.require(:feedback).permit(:message,:user_id)
	end

end