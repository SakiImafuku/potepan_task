require 'rails_helper'

describe '商品カテゴリー', type: :system, js: true do
  describe '商品カテゴリーページ' do
    before do
      @taxonomy = create(:taxonomy, name: 'Categories')
      taxon_a = create(:taxon, name: 'Bags')
      taxon_b = create(:taxon, name: 'Mugs')
      product_a = create(:product, name: 'EXAMPLE TOTE')
      product_b = create(:product, name: 'EXAMPLE MUG')
      taxon_a.taxonomy = @taxonomy
      taxon_b.taxonomy = @taxonomy
      product_a.taxons << taxon_a
      product_b.taxons << taxon_b
      product_a.master.images.create(attachment_file_name: "Test_a")
      product_b.master.images.create(attachment_file_name: "Test_b")   
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
        expect(page).to have_title 'EXAMPLE TOTE - BIGBAG Store'
      end
    end

    context 'Mugsページに移動する' do
      before do
        click_link 'Categories'
      end

      it '正しくカテゴリーが表示される' do
        within "#taxonomy-#{@taxonomy.id}" do
          expect(page).to have_content 'Bags(1)'
          expect(page).to have_content 'Mugs(1)'
        end
      end

      it 'Mugsページに移動する' do
        click_link 'Mugs'
        expect(page).to have_title 'Mugs - BIGBAG Store'
      end
    end
  end
end
