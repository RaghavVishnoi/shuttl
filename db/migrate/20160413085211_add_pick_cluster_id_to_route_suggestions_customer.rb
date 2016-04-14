class AddPickClusterIdToRouteSuggestionsCustomer < ActiveRecord::Migration
  def change
    add_column :route_suggestions_customers, :pick_cluster_id, :integer
  end
end
