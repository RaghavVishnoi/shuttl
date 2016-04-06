class RouteSuggestionsRoutePoint < ActiveRecord::Base

	belongs_to :route_suggestions_slot

	validates :lat, presence: true
	validates :long, presence: true
	validates :route_suggestion_id, presence: true

	def self.find_route(id)
		self.find(id)
	end


end