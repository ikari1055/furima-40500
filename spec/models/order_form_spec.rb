require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user:)
    @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
  end

  context '内容に問題ない場合' do
    it '全ての項目が入力されていれば登録できる' do
      expect(@order_form).to be_valid
    end

    it '建物名が空でも登録できる' do
      @order_form.building = ''
      expect(@order_form).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'カード情報が空では購入できない' do
      @order_form.token = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Token can't be blank")
    end

    it '郵便番号が空では購入できない' do
      @order_form.postal_code = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号が正しい形式でないと購入できない' do
      @order_form.postal_code = '1234567'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it '都道府県が選択されていないと購入できない' do
      @order_form.prefecture_id = 1
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '市区町村が空では購入できない' do
      @order_form.city = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空では購入できない' do
      @order_form.addresses = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Addresses can't be blank")
    end

    it '電話番号が空では購入できない' do
      @order_form.phone_number = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号が9桁以下では登録できない' do
      @order_form.phone_number = '123456789'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Enter 10 or 11 digits')
    end

    it '電話番号が12桁以上では登録できない' do
      @order_form.phone_number = '123456789012'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Enter 10 or 11 digits')
    end

    it '電話番号が数字以外を含んでいると購入できない' do
      @order_form.phone_number = '090-1234-5678'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'user_idが空では登録できない' do
      @order_form.user_id = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空では登録できない' do
      @order_form.item_id = nil
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Item can't be blank")
    end
  end
end
