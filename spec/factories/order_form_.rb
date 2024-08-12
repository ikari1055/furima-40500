FactoryBot.define do
  factory :order_form do
    postal_code      { '123-4567' }
    prefecture_id    { 2 } # 仮のデータ
    city             { '東京都' }
    addresses        { '1-1-1' }
    building         { '東京ハイツ' }
    phone_number     { '09012345678' }
    token            { 'tok_abcdefghijk00000000000000000' } # 仮のトークンデータ
    user_id { create(:user).id }
    item_id { create(:item).id }
  end
end
