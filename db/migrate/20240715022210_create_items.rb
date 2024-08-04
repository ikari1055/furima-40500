class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :description, null: false
      t.integer :condition_id, null: false
      t.integer :shipping_cost_id, null: false
      t.integer :shipping_days_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :product_category_id, null: false
      t.references :user, null: false, foreign_key: true
      t.boolean :sold_out, default: false, null: false 


      t.timestamps
    end

    add_index :items, :product_category_id
    add_index :items, :user_id
    add_index :items, :condition_id
    add_index :items, :shipping_cost_id
    add_index :items, :shipping_days_id
    add_index :items, :prefecture_id
  end
end
