class OrdersController < ApplicationController
  before_action :set_item, only: [:new, :create]

  def new
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      @order_form.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      render :new
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_form_params
    params.require(:order_form).permit(:user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building,
                                       :phone_number, :token)
  end
end
