class AddColumnIntoRouteSuggestionsPledges < ActiveRecord::Migration
  def change
  	add_column :route_suggestions_pledges,:route_suggestions_timestamp_id,:integer
  	add_foreign_key :route_suggestions_pledges,:route_suggestions_timestamps
  end
end
