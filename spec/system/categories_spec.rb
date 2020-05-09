require 'rails_helper'

describe '商品カテゴリー', type: :system, js: true do
  let!(:taxonomy)  { create(:taxonomy, name: 'Categories') }
  let!(:taxon_a)   { create(:taxon,    name: 'Bags',         taxonomy: taxonomy) }
  let!(:taxon_b)   { create(:taxon,    name: 'Mugs',         taxonomy: taxonomy) }
  let!(:product_a) { create(:product,  name: 'EXAMPLE TOTE', taxons: [taxon_a]) }
  let!(:product_b) { create(:product,  name: 'EXAMPLE MUG',  taxons: [taxon_b]) }

  before do
    product_a.images.create(attachment_file_name: "Test_a")
    product_b.images.create(attachment_file_name: "Test_b")
  end

  it '商品詳細ページに移動する' do
    visit potepan_category_path(taxon_a.id)
    # タイトルが正しい
    expect(page).to have_title 'Bags - BIGBAG Store'
    # トップページへのリンクが正しい
    expect(page).to have_link 'ロゴ画像', href: potepan_path
    within '.navbar' do
      expect(page).to have_link 'HOME', href: potepan_path
    end
    within '.pageHeader' do
      expect(page).to have_link 'HOME', href: potepan_path
    end
    # 商品一覧が正しく表示されている
    within '.productBox' do
      expect(page).to have_content product_a.name
      expect(page).to have_content product_a.display_price
      expect(page).not_to have_content product_b.name
    end
    # 商品詳細ページに移動する
    within '.productArea' do
      click_link 'EXAMPLE TOTE'
    end
    expect(current_path).to eq potepan_product_path(product_a.id)
  end

  it '別のカテゴリーに移動する' do
    visit potepan_category_path(taxon_a.id)
    click_link 'Categories'
    # 正しくカテゴリーが表示されている
    within "#taxonomy-#{taxonomy.id}" do
      expect(page).to have_content "#{taxon_a.name}(1)"
      expect(page).to have_content "#{taxon_b.name}(1)"
    end
    # Mugsページに移動する
    click_link 'Mugs'
    expect(current_path).to eq potepan_category_path(taxon_b.id)
  end
end
