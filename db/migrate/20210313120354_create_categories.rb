class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.integer :account_id
      t.string :category_name
      t.string :category_display_name
      t.timestamp :created_at
      t.integer :locations ,array:true , default: []
    end
  end
end
