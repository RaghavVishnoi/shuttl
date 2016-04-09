# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

RouteSuggestion.create!([
	{name: 'Noida sector-2 to Noida sector-65',threshold: 1},
])

RouteSuggestionsSlot.create!([
	{name: 'Sector-2',lat: '28.5849339',long: '77.3107348',time: 0,route_suggestion_id: 1},
	{name: 'Sector-16',lat: '28.5849244',long: '77.3107455',time: 10,route_suggestion_id: 1},
	{name: 'Sector-18',lat: '28.5697189',long: '77.318321',time: 20,route_suggestion_id: 1},
	{name: 'Sector-44',lat: '28.5528596',long: '77.3276642',time: 25,route_suggestion_id: 1},
	{name: 'Noida city center',lat: '28.5747488',long: '77.3538323',time: 35,route_suggestion_id: 1},
	{name: 'Sector-66',lat: '28.6055319',long: '77.3718919',time: 50,route_suggestion_id: 1},
	{name: 'Sector-65',lat: '28.6119173',long: '77.3801268',time: 60,route_suggestion_id: 1},
])

RouteSuggestionsTimestamp.create!([
	{time_departure: '5:30',route_suggestion_id: 1}
])

RouteSuggestionsPledge.create!([
	{user_id: 1,approved: true,lat: '28.5849339',long: '77.3107348',is_pledge: 1,route_suggestions_slot_id: 2},
	{user_id: 2,approved: true,lat: '28.5849339',long: '77.3107348',is_pledge: 1,route_suggestions_slot_id: 2},
	{user_id: 3,approved: true,lat: '28.5697189',long: '77.318321',is_pledge: 1,route_suggestions_slot_id: 3},
	{user_id: 4,approved: true,lat: '28.5528596',long: '77.3276642',is_pledge: 1,route_suggestions_slot_id: 4},
	{user_id: 5,approved: true,lat: '28.5747488',long: '77.3538323',is_pledge: 1,route_suggestions_slot_id: 5},
	{user_id: 6,approved: true,lat: '28.6055319',long: '77.3718919',is_pledge: 1,route_suggestions_slot_id: 6},
	{user_id: 7,approved: true,lat: '28.6055319',long: '77.3718919',is_pledge: 1,route_suggestions_slot_id: 6},
	{user_id: 8,approved: true,lat: '28.6119173',long: '77.3801268',is_pledge: 1,route_suggestions_slot_id: 7}
])

RouteSuggestionsRoutePoint.create!([
	{route_suggestion_id: 1,lat: '28.5849339',long: '77.3107348'},
])
