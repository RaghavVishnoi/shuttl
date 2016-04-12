class CreateRouteSuggestionsRoutes < ActiveRecord::Migration
  def change
    create_table :route_suggestions_routes do |t|
    	t.string :start
    	t.string :stop
    	t.string :name
    	t.string :people
    	t.string :type
    	t.integer :points
    	t.string :distance
    	t.string :eta
    	t.string :price
    	t.string :potential
    	t.string :pledge
    	t.integer :feedback_count
    	t.timestamps
    end
  end
end
