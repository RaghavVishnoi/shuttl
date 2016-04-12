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

	def self.send_link(route_id)
		@pickup_points = RouteSuggestionsRoute.pickup_points(route_id)
		puts "pickup_points #{@pickup_points}"
		@pickup_points.reject!(&:blank?).each do |point|
			@customers = RouteSuggestionsRoute.customers(point)
			puts "customers #{@customers}"
			if @customers.length != 0 && @customers != nil
				@customers.each do |customer|
					puts "customer #{customer.phone}"
					response = HTTParty.get("http://alerts.solutionsinfini.com/api/web2sms.php?workingkey=A9b72ac822242669f869659438ea113e2&to=#{customer.phone}&sender=SHUTTL&message=#{link(route_id)}")
					puts "request #{response}"
				end
			end
		end
		
	end



	def self.link(id)
		bitly = Bitly.new('o_qbfkcnm28', 'R_8ae4320040f04e6bac95071123aa6914')
		u = bitly.shorten('http://54.200.116.105/routes/saved?id='+id.to_s)
		u.bitly_url
	end

	

end