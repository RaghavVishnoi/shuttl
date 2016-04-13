class UpdateDatatypeIntoRouteSuggestionsCustomers < ActiveRecord::Migration
  def change
  	change_column :route_suggestions_customers,:from_lat,:float
  	change_column :route_suggestions_customers,:from_long,:float
  	change_column :route_suggestions_customers,:to_lat,:float
  	change_column :route_suggestions_customers,:to_long,:float
  end
end
