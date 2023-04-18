class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping
  belongs_to :prefecture
  belongs_to :shippingday
  has_one_attached :image
  belongs_to :user
  has_one :order, dependent: :destroy

    #空の投稿を保存できないようにする
    validates :image, :item_name, :explanation, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "が範囲外です" }
    validates :price, numericality: { only_integer: true, message: "は半角数字で入力してください" }

    #ジャンルの選択が「---」の時は保存できないようにする
    validates :category_id, numericality: { other_than: 1 , message: "が選択されていません"} 
    validates :condition_id, numericality: { other_than: 1 , message: "が選択されていません"} 
    validates :shipping_id, numericality: { other_than: 1 , message: "が選択されていません"} 
    validates :prefecture_id, numericality: { other_than: 1 , message: "が選択されていません"} 
    validates :shippingday_id, numericality: { other_than: 1 , message: "が選択されていません"} 
end
