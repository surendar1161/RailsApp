class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :name
      t.text :address
      t.integer :account_id
      t.string :phone
      t.integer :no_of_orders
    end
  end
end
