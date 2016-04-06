class CreateRouteSuggestionsSlots < ActiveRecord::Migration
  def change
    create_table :route_suggestions_slots do |t|
    	t.string :name,null: false
    	t.string :lat,null: false
    	t.string :long,null: false
    	t.integer :time,null: false
    	t.integer :route_suggestion_id
    	t.timestamps
    end
    add_foreign_key :route_suggestions_slots,:route_suggestions
  end
end
 