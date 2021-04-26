class CreateVendors < ActiveRecord::Migration[6.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :phone
      t.text :address
      t.integer :account_id
      t.integer :rating
      t.timestamp :created_at
    end
  end
end
