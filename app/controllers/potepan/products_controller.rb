class Potepan::ProductsController < ApplicationController
  DISPLAY_COUNT = 4
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.all_related_products.limit(DISPLAY_COUNT).
      includes(master: [:images, :default_price])
  end
end
