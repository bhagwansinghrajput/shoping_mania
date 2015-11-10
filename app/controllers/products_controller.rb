class ProductsController < ApplicationController
  autocomplete :category, :name
  before_filter :id_for_use, only: [:show, :update, :edit, :destroy]
  before_action :authenticate_user!, except: :search
  
  def index
    if current_user.is_user?
      @products = current_user.products.reorder('created_at DESC')
    else 
      current_user.is_buyer?
      @products = Product.all.reorder('created_at DESC')
    end 
  end

  def new
    if current_user.permission == true
      @product = current_user.products.new
    else
      flash[:error] = "Your are not eligible for add product."
      redirect_to products_path
    end 
  end
  
  def create 
    @product = current_user.products.new(product_params)
    Product.transaction do
      if @product.save
        category = Category.where("name ilike ?", params[:category_name]).first
        if params[:category_name].present?
          category.blank? ? category = @product.categories.create!(name: params[:category_name]) : @product.category_products.create!(:category_id => category.id)
        else
          flash[:error] = "Please fill category name."
          render 'new' and return
        end 
        flash[:success] = "Product added successfully."    
        redirect_to products_path
      else
        flash[:error] = @product.errors.full_mesages.join("<br>").html_safe
        render 'new'
      end
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
    if current_user.permission == true
      if @product.present?
        @product.destroy
        flash[:success] = "Product deleted."
        redirect_to products_path
      else
        flash[:error] = "Product not available."
        redirect_to products_path
      end
    else
      flash[:error] = "You can not delete product."
      products_path
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
        flash[:error] = "Orders not available." 
        redirect_to products_path
      end
    end  
  end

  def id_for_use
    @product = current_user.products.where("id = ?", params[:id]).first
  end

  def autocomplete_category_name
    @categories = Category.list_category_name(params[:term]).map(&:name)
    render :json => @categories
  end
  
  private
  
  def product_params
    params.require(:product).permit(:user_id, :name, :price, :quantity, :shipping_charge, :image, categories_attributes: [:name,:_destroy])
  end
  
end

