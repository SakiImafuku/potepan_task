module ProductsHelper
  def all_related_products(product)
    product.taxons.map do |taxon|
      taxon.all_products.includes(master: [:images, :default_price])
    end
  end
end
