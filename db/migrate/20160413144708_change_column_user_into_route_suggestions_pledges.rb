class ChangeColumnUserIntoRouteSuggestionsPledges < ActiveRecord::Migration
  def change
  	change_column :route_suggestions_pledges, :user_id, :integer, :null => true
  end
end
