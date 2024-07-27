FactoryBot.define do
  factory :item do
    name { 'Example Item' }
    description { 'This is an example item description.' }
    price { 1000 }
    condition_id { 2 }
    shipping_cost_id { 2 }
    shipping_days_id { 2 }
    prefecture_id { 2 }
    category_id { 2 }
    association :user # これでユーザーを関連付ける

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('public/images/test_image.png')), filename: 'test_image.png',
                        content_type: 'image/png')
    end
  end
end
