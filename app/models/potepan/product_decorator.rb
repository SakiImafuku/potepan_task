module Potepan::ProductDecorator
  def all_related_products
    Spree::Product.in_taxons(taxons).where.not(id: id).distinct
  end

  Spree::Product.prepend self
end