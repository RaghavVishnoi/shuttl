class CreateRouteDists < ActiveRecord::Migration
  def change
    create_table :route_dists do |t|
      t.integer :routeid
      t.integer :routeidD
      t.float :distance
      t.integer :duration

      t.timestamps null: false
    end
  end
end
