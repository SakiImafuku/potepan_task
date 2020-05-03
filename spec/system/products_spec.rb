require 'rails_helper'

describe '商品', type: :system do
  describe '商品詳細ページ' do
    before do
      taxon = create(:taxon, name: 'Bags')
      product = create(:product, name: 'EXAMPLE TOTE')
      product.taxons << taxon
      visit potepan_product_path(product.id)
    end

    context 'EXAMPLE TOTE詳細ページ' do
      it 'ページタイトルが正しく表示される' do
        expect(page).to have_title 'EXAMPLE TOTE - BIGBAG Store'
      end

      it '商品の情報が表示される' do
        within '.media-body' do
          expect(page).to have_content 'EXAMPLE TOTE'
          expect(page).to have_content '$19.99'
        end
      end
    end

    context 'トップページに移動する' do
      it 'ロゴをクリックする' do
        click_on 'ロゴ画像'
        expect(page).to have_title 'BIGBAG Store'
      end

      it 'ヘッダーのHOMEをクリックする' do
        within '.navbar' do
          click_on 'HOME'
        end
        expect(page).to have_title 'BIGBAG Store'
      end

      it '商品詳細ページ内のHOMEをクリックする' do
        within '.pageHeader' do
          click_on 'HOME'
        end
        expect(page).to have_title 'BIGBAG Store'
      end
    end
  end
end
