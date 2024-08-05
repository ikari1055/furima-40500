class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_one_attached :image

  belongs_to :category
  belongs_to :user
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :prefecture
  has_one :order_history # 追加

  validates :name, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :description, presence: true
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_cost_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :image, presence: true

  def sold_out?
    order_history.present?
  end

  def shipping_fee
    case shipping_cost_id
    when 1
      '---'
    when 2
      '着払い(購入者負担)'
    when 3
      '送料込み(出品者負担)'
    else
      '送料未定'
    end
  end

  def star_count
    # ここでは仮の値を返します。実際には、評価機能が実装されたら適切な計算を行います。
    5
  end
end
