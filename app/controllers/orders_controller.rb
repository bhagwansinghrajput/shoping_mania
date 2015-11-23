class OrdersController < ApplicationController
before_filter :available_quantity, only: [:create]
before_filter :initialize_cart_items_to_buy, only: [:create]
before_action :authenticate_user!
helper_method :current_user_session, :current_user, :get_shipping_charge, :get_all_amount

  def index
    if current_user.orders.present?
      @orders = current_user.orders.reorder('id DESC')
    else
      flash[:error] = "Orders not available" 
      redirect_to cart_item_index_path and return
    end
  end
  
  def create
    @order = current_user.orders.create
    if @order.present?
      @order.update_order_datail
      @order.update_order
      redirect_to @order
    end
    unless @order
      flash[:error] = "order not ctreated"
      redirect_to cart_item_index_path
    end
  end

  def available_quantity
    @cart = current_user.cart
    if @cart.cart_items.present?
      is_available, item_name  = @cart.check_quantity 
      unless is_available
        flash[:error] = "#{item_name} is not available."
        redirect_to home_index_path and return
      end
    else
      flash[:error] = "Your cart is blank please add items first."
      redirect_to home_index_path and return
    end

  end

  def show
    @order = current_user.orders.where("id = ?", params[:id]).first
    if @order.blank?
      flash[:error] = "orders not available"
      redirect_to home_index_path
    end
  end
  
  private


  def initialize_cart_items_to_buy
    @cart = current_user.cart
    @cart_items = params[:item_id].present? ? @cart.cart_items.where("id = ?", params[:item_id].to_i) : @cart.cart_items
    if @cart_items.blank?
      flash[:error] = "No item available in your cart. Please add first to buy."
      redirect_to home_index_path
    end
  end
end
