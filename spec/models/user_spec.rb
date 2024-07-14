require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '正常系' do
      it '全ての項目が入力されていれば登録できる' do
        @user = FactoryBot.build(:user)
        expect(@user).to be_valid
      end
    end

    context '異常系' do
      it 'nicknameが空では登録できない' do
        @user = FactoryBot.build(:user, nickname: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user = FactoryBot.build(:user, email: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したメールアドレスは登録できない' do
        FactoryBot.create(:user, email: 'test@example.com')
        @user = FactoryBot.build(:user, email: 'test@example.com')
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it 'メールアドレスに@を含まない場合は登録できない' do
        @user = FactoryBot.build(:user, email: 'testexample.com')
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが空では登録できない' do
        @user = FactoryBot.build(:user, password: '', password_confirmation: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが6文字未満では登録できない' do
        @user = FactoryBot.build(:user, password: '12345', password_confirmation: '12345')
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it '英字のみのパスワードでは登録できない' do
        @user = FactoryBot.build(:user, password: 'abcdef', password_confirmation: 'abcdef')
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it '数字のみのパスワードでは登録できない' do
        @user = FactoryBot.build(:user, password: '123456', password_confirmation: '123456')
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user = FactoryBot.build(:user, password: 'ｐａｓｓｗｏｒｄ123', password_confirmation: 'ｐａｓｓｗｏｒｄ123')
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        @user = FactoryBot.build(:user, password: 'password123', password_confirmation: 'password456')
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '姓（全角）が空だと登録できない' do
        @user = FactoryBot.build(:user, last_name: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user = FactoryBot.build(:user, last_name: 'yamada')
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it '名（全角）が空だと登録できない' do
        @user = FactoryBot.build(:user, first_name: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '名（全角）に半角文字が含まれていると登録できない' do
        @user = FactoryBot.build(:user, first_name: 'tarou')
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it '姓（カナ）が空だと登録できない' do
        @user = FactoryBot.build(:user, last_name_kana: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it '姓（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        @user = FactoryBot.build(:user, last_name_kana: 'やまだ')
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end

      it '名（カナ）が空だと登録できない' do
        @user = FactoryBot.build(:user, first_name_kana: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        @user = FactoryBot.build(:user, first_name_kana: 'たろう')
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it '生年月日が空だと登録できない' do
        @user = FactoryBot.build(:user, birth_date: '')
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
