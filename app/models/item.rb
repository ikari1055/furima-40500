class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_one_attached :image

  belongs_to :category
  belongs_to :user
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_days
  belongs_to_active_hash :prefecture

  validates :name, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :description, presence: true
  validates :condition_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_cost_id, presence: true
  validates :shipping_days_id, presence: true
  validates :prefecture_id, presence: true
  validates :category_id, presence: true
  validates :image, presence: true

  def sold_out?
    sold_out
  end

  def shipping_fee
    case shipping_cost_id
    when 1
      '送料無料'
    when 2
      '500円'
    when 3
      '1000円'
    else
      '送料未定'
    end
  end

  def star_count
    # ここでは仮の値を返します。実際には、評価機能が実装されたら適切な計算を行います。
    5
  end
end
