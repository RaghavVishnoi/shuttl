class CreateRouteSuggestionsCustomer < ActiveRecord::Migration
  def change
    create_table :route_suggestions_customers do |t|
    	t.string :from_lat
    	t.string :from_long
    	t.string :to_lat
    	t.string :to_long
    	t.string :time1
    	t.string :time2
    	t.string :phone
    end
  end
end
