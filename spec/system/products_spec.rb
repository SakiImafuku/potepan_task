require 'rails_helper'

describe '商品詳細', type: :system do
  let!(:taxonomy)            { create(:taxonomy, name: 'Categories') }
  let!(:taxon_a)             { create(:taxon,    name: 'Bags',         taxonomy: taxonomy) }
  let!(:taxon_b)             { create(:taxon,    name: 'Mugs',         taxonomy: taxonomy) }
  let!(:product_a)           { create(:product,  name: 'EXAMPLE TOTE', taxons: [taxon_a]) }
  let!(:not_related_product) { create(:product,  name: 'EXAMPLE MUG',  taxons: [taxon_b]) }
  let!(:related_product_1)   { create(:product,  name: 'EXAMPLE BAG1', taxons: [taxon_a]) }
  let!(:related_product_2)   { create(:product,  name: 'EXAMPLE BAG2', taxons: [taxon_a]) }
  let!(:related_product_3)   { create(:product,  name: 'EXAMPLE BAG3', taxons: [taxon_a]) }
  let!(:related_product_4)   { create(:product,  name: 'EXAMPLE BAG4', taxons: [taxon_a]) }
  let!(:related_product_5)   { create(:product,  name: 'EXAMPLE BAG5', taxons: [taxon_a]) }

  before do
    product_a.images.create(attachment_file_name: "Test_a")
    related_product_1.images.create(attachment_file_name: "Test_related_product")
    related_product_2.images.create(attachment_file_name: "Test_related_product")
    related_product_3.images.create(attachment_file_name: "Test_related_product")
    related_product_4.images.create(attachment_file_name: "Test_related_product")
  end

  it '関連商品ページに移動する' do
    visit potepan_product_path(product_a.id)
    # タイトルが正しい
    expect(page).to have_title 'EXAMPLE TOTE - BIGBAG Store'
    # トップページへのリンクが正しい
    expect(page).to have_link 'ロゴ画像', href: potepan_path
    within '.navbar' do
      expect(page).to have_link 'HOME', href: potepan_path
    end
    within '.pageHeader' do
      expect(page).to have_link 'HOME', href: potepan_path
    end
    # 商品情報が表示される
    within '.media-body' do
      expect(page).to have_content product_a.name
      expect(page).to have_content product_a.display_price
    end
    # 関連商品4点表示する、関連商品以外は表示されない
    within '.productsContent' do
      expect(page).to have_content related_product_1.name
      expect(page).to have_content related_product_2.name
      expect(page).to have_content related_product_3.name
      expect(page).to have_content related_product_4.name
      expect(page).not_to have_content not_related_product.name
      expect(page).not_to have_content related_product_5.name
    end
    # 関連商品ページに移動する
    within '.productsContent' do
      click_link 'EXAMPLE BAG1'
    end
    expect(current_path).to eq potepan_product_path(related_product_1.id)
  end
end
