class CreateRouteSuggestionsRoutePoints < ActiveRecord::Migration
  def change
    create_table :route_suggestions_route_points do |t|
    	t.string :lat
    	t.string :long
    	t.integer :route_suggestion_id
    	t.timestamps
    end
    add_foreign_key :route_suggestions_route_points,:route_suggestions
  end
end
