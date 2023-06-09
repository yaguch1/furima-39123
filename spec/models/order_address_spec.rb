require 'rails_helper'

RSpec.describe OrderAddress, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address,user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

   describe '商品購入機能' do
    context '購入できるとき' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@order_address).to be_valid
      end
      it '建物名が空でも購入できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入できないとき' do
      it '郵便番号は空では購入できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号は『3桁ハイフン4桁』の半角英数字でないと購入できない' do
        @order_address.post_code = '123-123４'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号が不正です. 例のように入力してください (例 123-4567)")
      end
      it 'prefecture未選択だと購入できない' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県が選択されていません")
      end
      it 'cityが空だと購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'addressが空だと購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'telephone_numberが空だと購入できない' do
        @order_address.telephone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'telephone_numberが9桁以下だと購入できない' do
        @order_address.telephone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号が不正です. 数字のみ入力してください")
      end
      it 'telephone_numberが12桁以上だと購入できない' do
        @order_address.telephone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号が不正です. 数字のみ入力してください")
      end
      it 'telephone_numberが半角数値でないと購入できない' do
        @order_address.telephone_number = '０9012341234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号が不正です. 数字のみ入力してください")
      end
      it 'user_idが紐づいていなければ購入できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("会員情報を入力してください")
      end
      it 'item_idが紐づいていなければ購入できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("商品情報を入力してください")
      end
      it "tokenが空では購入できない" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("カード情報を入力してください")
      end

    end
  end
end
