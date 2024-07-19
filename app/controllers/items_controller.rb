class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: '商品が正常に登録されました。'
    else
      render :new
    end
  end

  def edit
    # before_action :set_item で @item をセットしているため、この行は不要です。
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: '商品が正常に更新されました。'
    else
      render :edit
    end
  end

  def show
    # before_action :set_item で @item をセットしているため、この行は不要です。
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: '商品が削除されました。'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :condition, :cost, :days, :prefecture_id, :category_id, :user_id, :image)
  end
end
