class CreateRouteDistTimes < ActiveRecord::Migration
  def change
    create_table :route_dist_times do |t|
      t.integer :routeid
      t.integer :routeidD
      t.float :distance
      t.integer :duration
      t.integer :eval_time

      t.timestamps null: false
    end
  end
end
