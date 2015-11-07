class HomeController < ApplicationController

  def index
    @categories = Category.all.uniq.pluck(:name)
    category = Category.where(:name => params[:categories_name]).first
    @products = category.present? ? category.products.all : Product.all.reorder('created_at DESC')
    @products = @products.paginate(:page => params[:page], :per_page => 5)
  end

end
  
