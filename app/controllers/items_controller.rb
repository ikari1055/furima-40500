class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :check_item_owner, only: [:edit, :update]

  def index
    @items = Item.recent_first
  end

  def show
  end

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

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: '商品が正常に更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @item.destroy
  #   redirect_to items_path, notice: '商品が削除されました。'
  # end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_day_id, :category_id, :image).merge(user_id: current_user.id)
  end

  def check_item_owner
    return unless @item.user != current_user

    redirect_to root_path, alert: 'このアイテムの編集権限がありません。'
  end
end
