class Cart < ActiveRecord::Base
  attr_accessor :name, :price, :quantity, :category
  belongs_to :user
  belongs_to :products
  has_many :cart_items
end
