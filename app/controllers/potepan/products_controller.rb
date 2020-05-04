class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @taxons = @product.taxons
    @related_products = [@product]
    @related_display_count = 4
  end
end
