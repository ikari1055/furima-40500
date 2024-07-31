class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, only: [:new, :create] # ログインしているユーザーのみアクセス許可

  def index
    @items = Item.all
  end

  # def show
  #   @item = Item.find(params[:id])
  # end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が出品されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def edit
  #   # @itemはbefore_actionで設定済み
  # end

  # def update
  #   if @item.update(item_params)
  #     redirect_to @item, notice: '商品が正常に更新されました。'
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @item.destroy
  #   redirect_to items_path, notice: '商品が削除されました。'
  # end

  private

  # def set_item
  #   @item = Item.find(params[:id])
  # end

  # def item_params
  #   params.require(:item).permit(:name, :price, :description, :condition_id, :shipping_cost_id, :prefecture_id,
  #                                :shipping_days_id, :category_id, :image).merge(user_id: current_user.id)
  # end
end
