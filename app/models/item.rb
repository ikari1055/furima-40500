class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :category
  belongs_to :user
  belongs_to :condition


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefacture
  belongs_to :productcategory
  belongs_to_active_hash :condition



  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :condition_id, presence: true, numericality: { other_than: 1 }
  validates :cost, presence: true
  validates :days, presence: true
  validates :prefecture_id, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :image, presence: true

end
