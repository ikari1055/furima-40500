class OrdersController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    # ロジックに応じて他のインスタンス変数を設定
  end

  def create
    @item = Item.find(params[:item_id])
    # 購入処理のロジックをここに記述
  end
end
