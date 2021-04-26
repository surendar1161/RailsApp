class CreateVendorProductMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :vendor_product_mappings do |t|
      t.integer :product_id
      t.integer :category_id
      t.integer :location
      t.integer :quantity
      t.integer :price
      t.string :stock_id
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
