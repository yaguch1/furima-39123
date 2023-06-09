require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end
      it 'passwordが半角英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'passwordが全角入力では登録できない' do
        @user.password = 'ＡＡＡＡＡ１'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'kanji_seiが空では登録できない' do
        @user.kanji_sei = ''
        @user.kana_sei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（姓）を入力してください')
      end
      it 'kanji_meiが空では登録できない' do
        @user.kanji_mei = ''
        @user.kana_mei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（名）を入力してください')
      end
      it 'kanji_seiが漢字・平仮名・片仮名以外だと登録出来ない' do
        @user.kanji_sei = 'aA1'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（姓）全角文字を使用してください')
      end
      it 'kanji_meiが漢字・平仮名・片仮名以外だと登録出来ない' do
        @user.kanji_mei = 'aA1'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（名）全角文字を使用してください')
      end
      it 'kana_seiが空では登録できない' do
        @user.kana_sei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（カタカナ姓）を入力してください')
      end
      it 'kana_meiが空では登録できない' do
        @user.kana_mei = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（カタカナ名）を入力してください')
      end
      it 'kana_seiが片仮名以外だと登録出来ない' do
        @user.kana_sei = 'aA1'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（カタカナ姓）全角カナを使用してください')
      end
      it 'kana_meiが片仮名以外だと登録出来ない' do
        @user.kana_mei = 'aA1'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（カタカナ名）全角カナを使用してください')
      end
      it 'date_of_birthが空では登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
