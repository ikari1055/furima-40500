class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :category
  belongs_to :user
  belongs_to :condition


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :productcategory
  belongs_to :prefecture
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :shipping_days





  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :description, presence: true
  validates :condition_id, presence: true, numericality: { other_than: 1 }
  validates :shipping_cost_id, presence: true
  validates :shipping_days_id, presence: true
  validates :cost, presence: true
  validates :days, presence: true
  validates :prefecture_id, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :image, presence: true

end
