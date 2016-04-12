class RenameColumnSlotsIntoRouteSuggestionsRoutes < ActiveRecord::Migration
  def change
  	rename_column :route_suggestions_routes, :type, :route_type
  end
end
