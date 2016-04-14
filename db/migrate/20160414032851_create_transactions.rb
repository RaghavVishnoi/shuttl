class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.text :phone_number
      t.integer :status_code

      t.timestamps null: false
    end
  end
end
