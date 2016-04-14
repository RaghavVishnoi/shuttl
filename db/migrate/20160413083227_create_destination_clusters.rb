class CreateDestinationClusters < ActiveRecord::Migration
  def change
    create_table :destination_clusters do |t|
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
