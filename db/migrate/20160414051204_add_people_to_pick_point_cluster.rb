class AddPeopleToPickPointCluster < ActiveRecord::Migration
  def change
    add_column :pick_point_clusters, :people, :integer
  end
end
