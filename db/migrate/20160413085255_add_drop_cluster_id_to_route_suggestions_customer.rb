class AddDropClusterIdToRouteSuggestionsCustomer < ActiveRecord::Migration
  def change
    add_column :route_suggestions_customers, :drop_cluster_id, :integer
  end
end
