class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.integer :location_id
      t.float :price
      t.integer :quantity
      t.string :name
      t.integer :supplier_id ,array:true , default: []
    end
  end
end
