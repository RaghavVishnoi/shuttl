class CreateRouteSuggestions < ActiveRecord::Migration
  def change
    create_table :route_suggestions do |t|
    	t.string :name,null: false
    	t.integer :threshold,null: false
    	t.timestamps
    end
  end
end
