class Order < ActiveRecord::Base

  belongs_to :user
  has_many :order_details

  def update_order
    if order_details.product.present?
      shipping_charge = self.order_details.map{|order_detail| order_detail.try(:product).try(:shipping_charge)}.sum
      total_amount = self.order_details.sum(:price) + shipping_charge 
      tax_amount = (total_amount * 5)/100
      net_amount = total_amount + tax_amount
      if self.update_attributes(net_amount: net_amount, shipping_charge: shipping_charge, tax_amount: tax_amount, shipping_date: Time.now.to_date+7)
        return true
      end
    else
      return false
    end
  end

  def update_order_datail
    @cart_items = self.user.cart.cart_items
    if @cart_items.present?
      @cart_items.each do |cart_item|
        self.order_details.create(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.price * cart_item.quantity)
        cart_item.product.update_attributes(sold_quantity: cart_item.product.sold_quantity + cart_item.quantity)
        cart_item.destroy
      end
    else
      return false
    end
  end  

 
end
