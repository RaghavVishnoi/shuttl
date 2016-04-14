class AddDescriptionToRouteSuggestionsCustomer < ActiveRecord::Migration
  def change
    add_column :route_suggestions_customers, :description, :string
  end
end
