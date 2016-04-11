class AddColumnIntoRouteSuggestionsCustomer < ActiveRecord::Migration
  def change
  	add_column :route_suggestions_customers,:mode,:string
  	add_column :route_suggestions_customers,:created_at,:datetime
  	add_column :route_suggestions_customers,:updated_at,:datetime
  end
end
