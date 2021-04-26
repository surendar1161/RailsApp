class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.bigint :monday_account_id
      t.timestamp :created_at
      t.integer :account_status
      t.integer :locations ,array:true , default: []
      t.integer :plan_type
    end
  end
end
