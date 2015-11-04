class ProductsController < ApplicationController
  before_filter :id_for_use, only: [:show, :update, :edit, :destroy]

  def index
    if current_user.is_user?
      @products = current_user.products.reorder('name ASC')
    else 
      current_user.is_buyer?
      @products = Product.all
    end  
    
    if params[:search].present?
      @products = @products.search(params[:search])
    end 
  end
  
  def all_orders
    if current_user.is_user?
      @view_orders = Order.joins(:order_details).where("order_details.product_id in (?)", current_user.products.map(&:id)) 
    end  
  end
  
  def new
    @product = current_user.products.new
    @product.categories.build
  end
  
  def create 
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def show
  end 
  
  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def id_for_use
    @product = current_user.products.where("id = ?", params[:id]).first
  end
  
  def destroy
    @product.destroy
    redirect_to products_path
  end
  
  private
  
  def product_params
    params.require(:product).permit(:user_id, :name, :price, :quantity, :shipping_charge, :image, categories_attributes: [:name,:_destroy])
  end
end

