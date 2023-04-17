class OrderAddress

  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building, :telephone_number, :user_id, :item_id

  # ここにバリデーションの処理を書く

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank"}
    validates :city
    validates :address
    validates :telephone_number, format: {with: /\A[0-9]{11}\z/, message: "is invalid. Input only number"}
  end
    validates :telephone_number,length: { minimum: 10, message: "is too short." }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)

    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building: building, telephone_number: telephone_number, order_id: order.id)
  end
end