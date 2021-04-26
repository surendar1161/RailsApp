class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :account_id
      t.string :order_id
      t.float :total_price
      t.integer :status
      t.integer :delivery_person_id
      t.integer :customer_id
      t.boolean :invoice_generated
      t.string :payment_done
      t.timestamp :order_date
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
