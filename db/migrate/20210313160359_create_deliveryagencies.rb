class CreateDeliveryagencies < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_agencies do |t|
      t.string :agency_name
      t.integer :account_id
      t.string :address
      t.string :phone
      t.integer :location
      t.boolean :is_active
      t.integer :rating
      t.timestamp :created_at
    end
  end
end
