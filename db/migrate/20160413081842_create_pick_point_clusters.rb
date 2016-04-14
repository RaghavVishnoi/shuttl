class CreatePickPointClusters < ActiveRecord::Migration
  def change
    create_table :pick_point_clusters do |t|
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
