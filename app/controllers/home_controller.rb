class HomeController < ApplicationController

  def index
    # @products = Product.all
    @products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => 5)
    @categories = Category.all.uniq.pluck(:name)
    
  end
end
  
