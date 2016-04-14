class AddRadiusToPickPointCluster < ActiveRecord::Migration
  def change
    add_column :pick_point_clusters, :radius, :float
  end
end
