class CreateCustomerRoutes < ActiveRecord::Migration
  def change
    create_table :customer_routes do |t|
    	t.string :lat
    	t.string :long
    	t.string :name
    	t.timestamps
    end
  end
end
