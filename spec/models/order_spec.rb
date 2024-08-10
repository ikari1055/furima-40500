require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user_id: @user.id, item_id: @item.id)
  end

  describe 'Orderモデルのバリデーションテスト' do
    context '購入ができる場合' do
      it '全ての項目が正しく入力されていれば購入できる' do
        expect(@order).to be_valid
      end
    end

    context '購入ができない場合' do
      it '郵便番号が空では購入できない' do
        @order.postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('郵便番号を入力してください')
      end

      it '郵便番号が正しいフォーマットでなければ購入できない' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it '都道府県が選択されていなければ購入できない' do
        @order.prefecture_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('都道府県を入力してください')
      end

      it '市区町村が空では購入できない' do
        @order.city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('市区町村を入力してください')
      end

      it '番地が空では購入できない' do
        @order.addresses = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('番地を入力してください')
      end

      it '電話番号が空では購入できない' do
        @order.phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号を入力してください')
      end

      it '電話番号が12桁以上では購入できない' do
        @order.phone_number = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号は不正な値です')
      end

      it '電話番号が英数字混合では購入できない' do
        @order.phone_number = '090abcd1234'
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号は不正な値です')
      end
    end
  end
end
