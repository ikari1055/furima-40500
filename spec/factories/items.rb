FactoryBot.define do
  factory :item do
    name { "MyString" }
    price { "MyString" }
    description { "MyString" }
    condition { "MyString" }
    cost { "MyString" }
    days { "MyString" }
    prefecture_id { "MyString" }
    category_id { 1 }
    user_id { 1 }
  end
end
