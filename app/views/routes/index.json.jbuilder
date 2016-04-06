json.result true
json.data do 
	json.name @route_slot.name
	json.lat  @route_slot.lat
	json.long @route_slot.long
	json.time RouteSuggestionsTimestamp.slot_time(@route_slot.route_suggestion_id,@route_slot.id)
	json.pledge_count RouteSuggestionsPledge.where(route_suggestions_slot_id: RouteSuggestion.find(@route_slot.route_suggestion_id).route_suggestions_slots.pluck(:id),is_pledge: 1).count
end