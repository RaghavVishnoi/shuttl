class AddColumnSlotsIntoRouteSuggestionsRoutes < ActiveRecord::Migration
  def change
  	add_column :route_suggestions_routes,:slots,:text  	
  end
end
