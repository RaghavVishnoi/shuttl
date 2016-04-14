class AddRadiusToDestinationCluster < ActiveRecord::Migration
  def change
    add_column :destination_clusters, :radius, :float
  end
end
