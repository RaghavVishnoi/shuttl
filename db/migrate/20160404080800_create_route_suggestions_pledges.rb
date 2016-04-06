class CreateRouteSuggestionsPledges < ActiveRecord::Migration
  def change
    create_table :route_suggestions_pledges do |t|
    	t.integer :user_id,null: false
    	t.boolean :approved
    	t.string :lat,null: false
    	t.string :long,null: false
    	t.integer :is_pledge
    	t.integer :route_suggestions_slot_id
    	t.timestamps
    end
    add_foreign_key :route_suggestions_pledges,:route_suggestions_slots
  end
end
