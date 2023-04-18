require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できるとき' do
      it 'image、item_name、explanation、category_id、condition_id、shipping_id、prefecture_id、shippingday_id、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を入力してください")
      end
      it 'item_nameが空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'explanationが空では登録できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'category未選択だと登録できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーが選択されていません")
      end
      it 'condition未選択だと登録できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態が選択されていません")
      end
      it 'shipping未選択だと登録できない' do
        @item.shipping_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担が選択されていません")
      end
      it 'prefecture未選択だと登録できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域が選択されていません")
      end
      it 'shippingday未選択だと登録できない' do
        @item.shippingday_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数が選択されていません")
      end
      it 'priceが空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格が範囲外です", "価格は半角数字で入力してください")
      end
      it 'priceが全角数字だと出品できない' do
        @item.price = "１０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は半角数字で入力してください")
      end
      it 'priceが300より小さいと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格が範囲外です")
      end
      it 'priceが9999999より大きいと登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格が範囲外です")
      end
      it 'userが紐づいていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("会員情報を入力してください")
      end
    end
  end
end

