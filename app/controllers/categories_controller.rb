class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @items = @category.items.recent_first
  end
end
