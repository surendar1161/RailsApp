class CreateDeliveryagents < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveryagents do |t|
      t.integer :agency_id
      t.string :agent_name
      t.string :phone
      t.boolean :is_active
      t.integer :total_orders , default: 0
      t.integer :rating
      t.timestamp :created_at
    end
  end
end
