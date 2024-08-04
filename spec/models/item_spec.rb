require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user) # 明示的にユーザーを作成
    @item = FactoryBot.build(:item, user: @user) # ユーザーを関連付けてアイテムを作成
  end

  context 'アイテム新規登録 正常系' do
    it '全ての項目が入力されていれば登録できる' do
      expect(@item).to be_valid
    end
  end

  context 'アイテム新規登録 異常系' do
    it '商品名が空では登録できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品の説明が空では登録できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it 'カテゴリーが選択されていないと登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it '商品の状態が選択されていないと登録できない' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition を選択してください')
    end

    it '配送料の負担が選択されていないと登録できない' do
      @item.shipping_cost_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping cost can't be blank")
    end

    it '発送元の地域が選択されていないと登録できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '発送までの日数が選択されていないと登録できない' do
      @item.shipping_days_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping days can't be blank")
    end

    it '価格が空では登録できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が300未満では登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が9,999,999を超えると登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it '価格が整数でない場合は登録できない' do
      @item.price = 1000.5
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be an integer')
    end

    # 画像が空では保存できないことを確認するテストコード
    it '画像が空では保存できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    # 商品価格に関して、半角数字以外の値が含まれている場合は保存できないこと確認するテストコード
    it '商品価格に半角数字以外の値が含まれている場合は保存できない' do
      @item.price = '1000円'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end

    # userが紐づいていないと保存できないことを確認するテストコード
    it 'userが紐づいていないと保存できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end
  end
end
