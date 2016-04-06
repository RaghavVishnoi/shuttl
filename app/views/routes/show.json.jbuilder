json.result true
json.data do
	json.partial! "api/v1/routes/slot", collection: @route_slots, as: :route_slot
end