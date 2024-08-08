# app/models/order_form.rb
class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  # バリデーションの定義
  validates :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :phone_number, :token, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }

  def save
    # 購入情報を保存し、返されたorderのidを使用
    order = Order.create(user_id:, item_id:)
    # 住所情報を保存する
    Address.create(postal_code:, prefecture_id:, city:, addresses:, building:,
                   phone_number:, order_id: order.id)
  end
end
