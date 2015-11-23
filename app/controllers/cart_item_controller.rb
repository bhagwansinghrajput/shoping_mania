class CartItemController < ApplicationController
  before_action :authenticate_user!
  before_filter :product_presence_and_authenticate, only: [:create]

  def index
    @cart_items = current_user.cart_items
  end
  
  def create
    @cart_item = current_user.cart.cart_items.build(product_id: @product.id, name: @product.name, price: @product.price, quantity: params[:quantity]) 
    if @cart_item.save
      flash[:success] = "Item added to your cart successfully."
      redirect_to cart_item_index_path and return
    else
      flash[:error] = @cart_item.errors.full_messages
      render 'new'
    end
  end

  def destroy
    @cart_item = current_user.cart.cart_items.where("id = ?", params[:id]).first
    if @cart_item.present?
      @cart_item.destroy
    else
      flash[:error] = "item not available"
      redirect_to cart_item_index_path
    end
    redirect_to cart_item_index_path
  end
   
  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :cart_id, :name, :price, :quantity, :_destroy) 
  end 

  def product_presence_and_authenticate
    @product = Product.where("id = ?", params[:id].to_i).first
    if @product.present?
      unless @product.available_quantity >= params[:quantity].to_i
        flash[:error] = "#{@product.name} of Quantity not available" 
        redirect_to home_index_path and return
      end 
    else
      flash[:error] = "Product not available." 
      redirect_to home_index_path and return
    end 
  end
  
end
