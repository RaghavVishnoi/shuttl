class RouteExistsController < ApplicationController

	def index

		routeId=params[:routeId]
		timeFrom=Timestamp.where(:routeid=>routeId).where(:deleted=>0)
		@timeA=Array.new
		@timeD=Array.new
		@frequency=Array.new
		timeFrom.each do |t|
			@timeA.push t.fromtime
			@timeD.push t.totime
			@frequency.push t.interval
		end

		@route=Route.find_by(:id=>routeId)
		@slots=Slot.where(:routeid=>routeId).joins("join locations on locations.id=slots.locationid").select("locations.lat,locations.lng,slots.*")
	end


end	