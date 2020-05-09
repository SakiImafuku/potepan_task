class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.all_related_products.limit(4).
      includes(master: [:images, :default_price])
  end
end
