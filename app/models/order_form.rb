class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  # バリデーションの定義
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A\d+\z/, message: 'is invalid. Input only number' },
                             length: { in: 10..11, message: 'is invalid. Enter 10 or 11 digits' }
    validates :token
  end

  def save
    order = OrderHistory.create(user_id:, item_id:)
    # 住所情報を保存する
    Address.create(postal_code:, prefecture_id:, city:, addresses:,
                   building:, phone_number:, order_history_id: order.id)
  end

  private
end
