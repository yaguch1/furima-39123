class OrderAddress

  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building, :telephone_number, :user_id, :item_id
  attr_accessor :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "が不正です. 例のように入力してください (例 123-4567)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "が選択されていません"}
    validates :city
    validates :address
    validates :telephone_number, format: {with: /\A[0-9]{10,11}\z/, message: "が不正です. 数字のみ入力してください"}
    validates :token
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)

    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building: building, telephone_number: telephone_number, order_id: order.id)
  end
end