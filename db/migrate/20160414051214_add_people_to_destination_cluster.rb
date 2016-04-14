class AddPeopleToDestinationCluster < ActiveRecord::Migration
  def change
    add_column :destination_clusters, :people, :integer
  end
end
