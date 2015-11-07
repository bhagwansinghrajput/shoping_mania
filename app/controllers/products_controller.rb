class ProductsController < ApplicationController
  autocomplete :category, :name
  before_filter :id_for_use, only: [:show, :update, :edit, :destroy]
  before_action :authenticate_user!
  
  def index
    if current_user.is_user?
      @products = current_user.products.reorder('created_at DESC')
    else 
      current_user.is_buyer?
      @products = Product.all.reorder('created_at DESC')
    end 
  end

  def new
    @product = current_user.products.new

   
  end
  
  def create 
    @product = current_user.products.new(product_params)
    
    if @product.save
      Product.transaction do
        category = Category.where("name ilike ?", params[:category_name]).first
        category.blank? ? category = @product.categories.create(name: params[:category_name]) : @product.category_products.create(:category_id => category.id)
      end     
      redirect_to products_path
    else
      render 'new'
    end
  end
  
  def update
    if @product.update(product_params)
      redirect_to @product
      if @product.blank?
        redirect_to home_index_path
      end
    else
      render 'edit'
    end
  end

  def destroy
    if @product.present?
      @product.destroy
      redirect_to products_path
    else
      flash[:error] = "product not available"
      redirect_to products_path
    end
  end


  def search
    if params[:search].present?
      @products = Product.search(params[:search])
    else
      @products = Product.all.reorder('created_at DESC')
    end 
  end

  def all_orders
    if current_user.is_user?
      @view_orders = Order.joins(:order_details).where("order_details.product_id in (?)", current_user.products.map(&:id))
      if @view_orders.blank?
        flash[:error] = "orders not available" 
        redirect_to products_path
      end
    end  
  end

  def id_for_use
    @product = current_user.products.where("id = ?", params[:id]).first
  end

  def autocomplete_category_name
    @categories = Category.autocomplete_category_name(params[:term]).map(&:name)
    render :json => @categories
  end
  
  private
  
  def product_params
    params.require(:product).permit(:user_id, :name, :price, :quantity, :shipping_charge, :image, categories_attributes: [:name,:_destroy])
  end
end

