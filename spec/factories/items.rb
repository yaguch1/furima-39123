FactoryBot.define do
  factory :item do
    item_name              {Faker::Name.name}
    explanation            {Faker::Lorem.paragraph}
    category_id            { 2 }
    condition_id           { 2 }
    shipping_id            { 2 }
    prefecture_id          { 2 }
    shippingday_id         { 2 }
    price                  {Faker::Number.between(from: 300, to: 9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_img.png'), filename: 'test_img.png')
    end
  end
end