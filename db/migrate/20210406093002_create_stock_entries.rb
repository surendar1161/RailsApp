class CreateStockEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_entries do |t|
      t.string :stock_id
      t.integer :payment_status
      t.integer :total_price 
      t.integer :account_id
      t.integer :vendor_id
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
