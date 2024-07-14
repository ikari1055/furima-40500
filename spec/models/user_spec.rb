require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '正常系' do
      it '全ての項目が入力されていれば登録できる' do
        user = User.new(
          nickname: 'testuser',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        expect(user).to be_valid
      end
    end

    context '異常系' do
      # nickname関連のテスト
      it 'nicknameが空では登録できない' do
        user = User.new(
          nickname: '',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end

      # email関連のテスト
      it 'emailが空では登録できない' do
        user = User.new(
          nickname: 'test',
          email: '',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したメールアドレスは登録できない' do
        User.create(
          nickname: 'test1',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user = User.new(
          nickname: 'test2',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Email has already been taken")
      end

      it 'メールアドレスに@を含まない場合は登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'testexample.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Email is invalid")
      end

      # パスワード関連のテスト
      it 'パスワードが空では登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: '',
          password_confirmation: '',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが6文字未満では登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: '12345',
          password_confirmation: '12345',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it '英字のみのパスワードでは登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'abcdef',
          password_confirmation: 'abcdef',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Password is invalid")
      end

      it '数字のみのパスワードでは登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: '123456',
          password_confirmation: '123456',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Password is invalid")
      end

      it '全角文字を含むパスワードでは登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'ｐａｓｓｗｏｒｄ123',
          password_confirmation: 'ｐａｓｓｗｏｒｄ123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Password is invalid")
      end

      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password456',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      # 姓・名（全角）関連のテスト
      it '姓（全角）が空だと登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end

      it '姓（全角）に半角文字が含まれていると登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: 'yamada',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Last name is invalid")
      end

      it '名（全角）が空だと登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("First name can't be blank")
      end

      it '名（全角）に半角文字が含まれていると登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: 'tarou',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("First name is invalid")
      end

      # 姓・名（カナ）関連のテスト
      it '姓（カナ）が空だと登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: '',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it '姓（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'やまだ',
          first_name_kana: 'タロウ',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana is invalid")
      end

      it '名（カナ）が空だと登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: '',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名（カナ）にカタカナ以外の文字が含まれていると登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'たろう',
          birth_date: '2000-01-01'
        )
        user.valid?
        expect(user.errors.full_messages).to include("First name kana is invalid")
      end

      # 生年月日関連のテスト
      it '生年月日が空だと登録できない' do
        user = User.new(
          nickname: 'test',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birth_date: ''
        )
        user.valid?
        expect(user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
