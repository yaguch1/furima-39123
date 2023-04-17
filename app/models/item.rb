class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping
  belongs_to :prefecture
  belongs_to :shippingday
  has_one_attached :image
  belongs_to :user

    #空の投稿を保存できないようにする
    validates :image, :item_name, :explanation, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range" }
    validates :price, numericality: { only_integer: true, message: "Half-width number." }

    #ジャンルの選択が「---」の時は保存できないようにする
    validates :category_id, numericality: { other_than: 1 , message: "can't be blank"} 
    validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"} 
    validates :shipping_id, numericality: { other_than: 1 , message: "can't be blank"} 
    validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"} 
    validates :shippingday_id, numericality: { other_than: 1 , message: "can't be blank"} 
end
