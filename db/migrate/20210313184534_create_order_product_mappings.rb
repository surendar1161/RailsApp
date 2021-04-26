class CreateOrderProductMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :order_product_mappings do |t|
      t.string :order_id
      t.integer :category_id
      t.integer :product_id
      t.float :price 
      t.integer :quantity
      t.timestamp :created_at
    end
  end
end
