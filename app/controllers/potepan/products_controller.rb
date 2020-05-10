class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    display_count = 4
    @related_products = @product.all_related_products.limit(display_count).
      includes(master: [:images, :default_price])
  end
end
