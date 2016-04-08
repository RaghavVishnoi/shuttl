class Feedback < ActiveRecord::Base

	validates :message, presence: true
	validates :user_id, presence: true

	def self.create(feedback_params)
		@feedbacks = JSON.parse(feedback_params[:message])
		@user_id = feedback_params[:user_id]
		@feedbacks.each do |feedback|
 			self.create!(message: feedback,user_id: @user_id)
		end
		self.where(user_id: @user_id)
	end

end
