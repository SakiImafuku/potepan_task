require 'rails_helper'

describe '商品', type: :system do
  describe '商品詳細ページ' do
    let!(:product) { FactoryBot.create(:product, name: 'EXAMPLE TOTE')}
    before do
      visit potepan_product_path(product.id)
    end

    context 'EXAMPLE TOTEページ' do
      it 'ページタイトルが正しく表示されている' do
        expect(page).to have_title   'EXAMPLE TOTE - BIGBAG Store'
      end

      it '商品の情報が表示される' do
        expect(page).to have_content 'EXAMPLE TOTE'
        expect(page).to have_content '$19.99'
      end
    end

  end
end