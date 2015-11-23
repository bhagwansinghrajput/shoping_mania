class CartItem < ActiveRecord::Base
  belongs_to :carts
  belongs_to :product
  validates :name, :quantity, :price, presence: true
  validates :price, numericality: { only_float: true }
  
  #apply validations
end
