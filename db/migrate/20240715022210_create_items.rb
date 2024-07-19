class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :description, null: false
      t.integer :condition_id, null: false
      t.integer :shipping_cost_id, null: false
      t.integer :shipping_days_id, null: false
      t.integer :days, null: false
      t.integer :prefecture_id, null: false
      t.integer :product_category_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :items, :product_category_id
    add_index :items, :user_id
  end
end
