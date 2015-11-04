class OrdersController < ApplicationController
before_filter :available_quantity, only: [:create]
before_filter :initialize_cart_items_to_buy, only: [:create]

  def index
    if current_user.orders.present?
      @orders = current_user.orders.reorder('id DESC')
    else
     flash[:error] = "Orders not available" 
     redirect_to cart_item_index_path and return
    end
  end
  
  def new
    
  end
  
  def create
    @order = current_user.orders.create
    create_order_datail
    shipping_charge = @order.order_details.map{|od| od.product.shipping_charge}.sum
    net_amount = @order.order_details.sum(:price) + shipping_charge
    tax_amount = (net_amount * 5)/100
    
    @order.update_attributes(net_amount: net_amount, shipping_charge: shipping_charge, tax_amount: tax_amount, shipping_date: Time.now.to_date+7)
    redirect_to @order
  end

  def available_quantity
    @cart_items = current_user.cart.cart_items
    @cart_items.each do |cart_item|
      product = cart_item.product
      if product.available_quantity.to_i < cart_item.quantity.to_i
        flash[:error] = "#{product.name} not available"
        redirect_to cart_item_index_path
      end
    end 
  end

  def show
    @order = current_user.orders.where("id = ?", params[:id]).first
  end
  
  private
  
  def create_order_datail
    @cart_items.each do |item|
      @order.order_details.create(product_id: item.product_id, quantity: item.quantity, price: item.price * item.quantity)
      item.product.update_attributes(sold_quantity: item.product.sold_quantity + item.quantity)
      item.destroy
    end
  end  

  def initialize_cart_items_to_buy
    @cart = current_user.cart
    @cart_items = params[:item_id].present? ? @cart.cart_items.where("id = ?", params[:item_id].to_i) : @cart.cart_items
    if @cart_items.blank?
      flash[:error] = "No item available in your cart. Please add first to buy."
      redirect_to home_index_path
    end
  end
end
