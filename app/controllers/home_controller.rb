class HomeController < ApplicationController

  def index
    @categories = Category.all.uniq.pluck(:name)
    category = Category.where(:name => params[:categories_name]).first
    @products = category.present? ? category.products : Product.all.reorder('created_at DESC')
<<<<<<< HEAD
    @products = @products.paginate(:page => params[:page], :per_page => 8)
=======
    @products = @products.paginate(:page => params[:page], :per_page => 5)
>>>>>>> master
  end

end
  
