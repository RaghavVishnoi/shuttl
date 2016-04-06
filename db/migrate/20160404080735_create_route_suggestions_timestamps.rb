class CreateRouteSuggestionsTimestamps < ActiveRecord::Migration
  def change
    create_table :route_suggestions_timestamps do |t|
    	t.time :time_departure
    	t.integer :route_suggestion_id
    	t.timestamps
    end
        add_foreign_key :route_suggestions_timestamps,:route_suggestions
  end
end
