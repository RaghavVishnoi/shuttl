class Message
	require 'httparty'
	def self.send(phone,otp)
		puts "phone #{phone} otp #{otp}"
		response = HTTParty.get("http://alerts.solutionsinfini.com/api/web2sms.php?workingkey=A9b72ac822242669f869659438ea113e2&to=#{phone}&sender=SHUTTL&message=#{message(otp)}")
		puts "request #{response}"
	end

	def self.message(otp)
		"Ahoy, welcome to Shuttl.Please enter #{otp} code to verify your number.The ride begins!"
	end

end