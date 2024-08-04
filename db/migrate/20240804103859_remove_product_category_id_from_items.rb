class RemoveProductCategoryIdFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :product_category_id, :integer
  end
end
