class OrdersController < ApplicationController
  before_action :authenticate_user! # ログインを要求する
  before_action :set_item, only: [:index, :create]
  before_action :check_access, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      # エラーが発生した場合、`new` ビューを再表示
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_form_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
          .merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_form_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def check_access
    if current_user.nil?
      redirect_to new_user_session_path, alert: 'ログインが必要です'
    elsif @item.user_id == current_user.id
      redirect_to root_path, alert: '自分が出品した商品は購入できません'
    elsif @item.sold_out?
      redirect_to root_path, alert: 'この商品はすでに売却済みです'
    end
  end
end
