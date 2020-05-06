class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.all.includes(:taxons)
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.all_products.includes(master: [:images, :default_price])
  end
end
