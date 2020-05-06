require 'rails_helper'

describe '商品カテゴリー', type: :system, js: true do
  describe '商品カテゴリーページ' do
    let!(:taxonomy)  { create(:taxonomy, name: 'Categories') }
    let!(:taxon_a)   { create(:taxon,    name: 'Bags',         taxonomy: taxonomy) }
    let!(:taxon_b)   { create(:taxon,    name: 'Mugs',         taxonomy: taxonomy) }
    let!(:product_a) { create(:product,  name: 'EXAMPLE TOTE', taxons: [taxon_a]) }
    let!(:product_b) { create(:product,  name: 'EXAMPLE MUG',  taxons: [taxon_b]) }

    before do
      product_a.images.create(attachment_file_name: "Test_a")
      product_b.images.create(attachment_file_name: "Test_b")
      visit potepan_category_path(taxon_a.id)
    end

    context 'Bagsページから商品詳細ページに移動する' do
      it 'ページタイトルが正しく表示される' do
        expect(page).to have_title 'Bags - BIGBAG Store'
      end

      it '商品一覧が正しく表示される' do
        within '.productBox' do
          expect(page).to have_content 'EXAMPLE TOTE'
          expect(page).to have_content '$19.99'
        end
      end

      it 'カテゴリーが異なる商品は表示されない' do
        expect(page).not_to have_content 'EXAMPLE MUG'
      end

      it '商品詳細ページに移動する' do
        within '.productArea' do
          click_link 'EXAMPLE TOTE'
        end
        expect(current_path).to eq potepan_product_path(product_a.id)
      end
    end

    context 'Mugsページに移動する' do
      before do
        click_link 'Categories'
      end

      it '正しくカテゴリーが表示される' do
        within "#taxonomy-#{taxonomy.id}" do
          expect(page).to have_content 'Bags(1)'
          expect(page).to have_content 'Mugs(1)'
        end
      end

      it 'Mugsページに移動する' do
        click_link 'Mugs'
        expect(current_path).to eq potepan_category_path(taxon_b.id)
      end
    end
  end
end
