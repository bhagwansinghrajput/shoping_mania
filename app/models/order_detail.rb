class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
<<<<<<< HEAD

  validates :quantity, :price, presence: true
  validates :price, numericality: { only_float: true }
=======
>>>>>>> master
end
