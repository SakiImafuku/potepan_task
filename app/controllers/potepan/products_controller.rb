class Potepan::ProductsController < ApplicationController
  MAX_DISPLAY_COUNT = 4
  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.all_related_products.limit(MAX_DISPLAY_COUNT).
      includes(master: [:images, :default_price])
  end
end
