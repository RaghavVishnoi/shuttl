class AddColumnPhoneIntoRouteSuggestionsPledges < ActiveRecord::Migration
  def change
  	add_column :route_suggestions_pledges,:phone,:string
  end
end
