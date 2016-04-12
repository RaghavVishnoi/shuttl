class AddColumnIntoRouteSuggestionsRoutes < ActiveRecord::Migration
  def change
  	add_column :route_suggestions_routes,:state,:string
  	add_column :route_suggestions_routes,:status,:string
  end
end
