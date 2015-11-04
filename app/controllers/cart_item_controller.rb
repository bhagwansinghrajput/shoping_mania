class CartItemController < ApplicationController

  def index
    @cart_item = current_user.cart_items
  end
  
  def new
    @cart_item = CartItem.new
  end
  
  def create
    @product = Product.where("id = ?", params[:id]).first
    if @product.available_quantity > params[:quantity].to_i
      current_user.build_cart.save if current_user.cart.blank?
      @cart_item = current_user.cart.cart_items.build(product_id: @product.id, name: @product.name, price: @product.price, quantity: params[:quantity]) if @product.present?
      if @cart_item.save
        flash[:success] = "Item added to your cart successfully."
        redirect_to cart_item_index_path and return
      else
        flash[:error] = @cart_item.errors.full_messages
        render 'new'
      end
    else
      flash[:error] = "#{@product.name} not available" 
      redirect_to home_index_path and return
    end 
  end
  
  def destroy
    @cart_item = current_user.cart.cart_items.where("id = ?", params[:id]).first
    @cart_item.destroy
    redirect_to cart_item_index_path
  end
   
  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :cart_id, :name, :price, :quantity, :_destroy) 
  end 
  
end
