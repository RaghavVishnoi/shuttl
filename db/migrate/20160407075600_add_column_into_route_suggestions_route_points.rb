class AddColumnIntoRouteSuggestionsRoutePoints < ActiveRecord::Migration
  def change
  	add_column :route_suggestions_route_points,:pickup_point_id,:integer
  	add_column :route_suggestions_route_points,:drop_point_id,:integer
  	 
  end
end
