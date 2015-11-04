class CategoriesController < ApplicationController

  def filter_products
    category = Category.where(:name => params[:categories_name]).first
    @category_products = category.present? ? category.products : Product.all
  end
end
