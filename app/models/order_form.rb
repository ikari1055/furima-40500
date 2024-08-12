class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  # バリデーションの定義
  validates :token, presence: { message: "can't be blank" }
  validates :postal_code, presence: { message: "can't be blank" },
                          format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :city, presence: { message: "can't be blank" }
  validates :addresses, presence: { message: "can't be blank" }
  validates :phone_number, presence: { message: "can't be blank" },
                           format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' },
                           length: { minimum: 10, message: 'is too short' }

  # カスタムバリデーションでuser_idとitem_idのエラーを削除
  validate :exclude_user_and_item_error_messages

  # def initialize(attributes = {})
  #   super
  #   # item_id が設定されている場合に価格を設定
  #   @price = Item.find(item_id).price if item_id
  # end

  def save
    # Order モデルを作成
    order = OrderHistory.create(user_id:, item_id:)
    # 住所情報を保存する
    Address.create(postal_code:, prefecture_id:, city:, addresses:,
                   building:, phone_number:, order_history_id: order.id)
  end

  private

  def exclude_user_and_item_error_messages
    errors.delete(:user_id)
    errors.delete(:item_id)
  end
end
