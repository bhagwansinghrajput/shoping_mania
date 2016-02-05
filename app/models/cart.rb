class Cart < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessor :name
  belongs_to :user
  belongs_to :products
  has_many :cart_items

  def check_quantity
    self.cart_items.each do |cart_item|
      is_available = (cart_item.product.available_quantity.to_i < cart_item.quantity.to_i) ? false : true
      return is_available, cart_item.name unless is_available
    end
    return true
  end 
=======
  attr_accessor :name, :price, :quantity, :category
  belongs_to :user
  belongs_to :products
  has_many :cart_items
>>>>>>> master
end
