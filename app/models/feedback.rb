class Feedback < ActiveRecord::Base

	validates :message, presence: true
	validate  :user_id 

	def self.create(params)
 		@feedbacks = params[:feedback][:message]
		@user_id = params[:feedback][:user_id]
		@feedbacks.each do |feedback|
 			self.create!(message: feedback,user_id: @user_id)
		end
		self.where(user_id: @user_id)
	end

end
