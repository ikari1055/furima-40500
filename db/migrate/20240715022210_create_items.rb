class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :price
      t.string :description
      t.string :condition
      t.string :cost
      t.string :days
      t.string :prefecture_id
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
