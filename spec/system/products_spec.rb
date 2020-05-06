require 'rails_helper'

describe '商品', type: :system do
  describe '商品詳細ページ' do
    let!(:taxonomy)  { create(:taxonomy, name: 'Categories') }
    let!(:taxon_a)   { create(:taxon,    name: 'Bags',         taxonomy: taxonomy) }
    let!(:taxon_b)   { create(:taxon,    name: 'Mugs',         taxonomy: taxonomy) }
    let!(:product_a) { create(:product,  name: 'EXAMPLE TOTE', taxons: [taxon_a]) }
    let!(:product_b) { create(:product,  name: 'EXAMPLE BAG',  taxons: [taxon_a]) }
    let!(:product_c) { create(:product,  name: 'EXAMPLE MUG',  taxons: [taxon_b]) }

    before do
      product_a.images.create(attachment_file_name: "Test_a")
      product_b.images.create(attachment_file_name: "Test_b")
      visit potepan_product_path(product_a.id)
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
        expect(current_path).to eq potepan_path
      end

      it 'ヘッダーのHOMEをクリックする' do
        within '.navbar' do
          click_on 'HOME'
        end
        expect(current_path).to eq potepan_path
      end

      it '商品詳細ページ内のHOMEをクリックする' do
        within '.pageHeader' do
          click_on 'HOME'
        end
        expect(current_path).to eq potepan_path
      end
    end

    context '関連商品の表示' do
      it '関連商品が表示される' do
        within '.productsContent' do
          expect(page).to have_content 'EXAMPLE BAG'
        end
      end

      it '関連商品以外は表示されない' do
        within '.productsContent' do
          expect(page).not_to have_content 'EXAMPLE MUG'
        end
      end

      it 'クリックしたら商品詳細ページに移動する' do
        within '.productsContent' do
          click_link 'EXAMPLE BAG'
        end
        expect(current_path).to eq potepan_product_path(product_b.id)
      end
    end
  end
end
